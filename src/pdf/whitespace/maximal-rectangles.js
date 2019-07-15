/* 
  given a bounding rectangle, and a list of text bounding boxes
  this class?/module? returns a list of bounding boxes for whitespace
  which meaningfully divide text.
*/

const MaximalRectangles = {
  findWhiteSpace: function(canvas) {
    console.log("Finding White Space");
    /*
      Extracted from Breuel2002.

      def find_whitespace(bound,rectangles):
          queue.enqueue(quality(bound),bound,rectangles)
          while not queue.is_empty():
              (q,r,obstacles) = queue.dequeue_max()
              if obstacles==[]:
                  return r
              pivot = pick(obstacles)
              r0 = (pivot.x1,r.y0,r.x1,r.y1)
              r1 = (r.x0,r.y0,pivot.x0,r.y1)
              r2 = (r.x0,pivot.y1,r.x1,r.y1)
              r3 = (r.x0,r.y0,r.x1,pivot.y0)
              subrectangles = [r0,r1,r2,r3]
              for sub_r in subrectangles:
                  sub_q = quality(sub_r)
                  sub_obstacles =
                      [list of u in obstacles if not overlaps(u,sub_r)]
                  queue.enqueue(sub_q,sub_r,sub_obstacles)
    */
   /*
    Breuel's algorithm turns out to be super sensitive to the order of the
    search being performed, and the unspecified quality function used in
    the algorithm.  In our case we'll use a search which first searches
    the vertical regions (to the left and right of the pivot) in order
    to try and find the tallest whiteSpaces.
    */

    // turn all of the items into bounding boxes
    // defined by their css measured dimensions.

    let queue = [canvas];
    let whiteSpaces = [];
    while (queue.length > 0) {
      //console.log({queue: queue.length, whiteSpaces: whiteSpaces.length});
      //if (queue.length > 1000) { break; }
      // get the next region to search
      let bounds = queue.shift();

      // find the element that divides the region most evenly
      let pivot = bounds.findPivot();

      //let partitions = bounds.partition(pivot);
      //let regions = [leftRegion, rightRegion, upperRegion, lowerRegion].filter( 
      let regions = Object.values(bounds.partition(pivot)).filter(
        // some pivots have boundaries outside of the region.
        // this prevents regions where the left/right or top/bottom boundaries are inverted.
        region => region.width > 0 && region.height > 0
      );

      let processRegion = (region) => {
        // if this region contains text elements
        if (region.items.length > 0){
          queue.push(region); // queue it for further subdivision
        } else {
          // otherwise the region is empty, and we should figure out
          // if it meaningfully divides any text elements.
          let subregions = canvas.intersectingPartition(region, ['left','right']);
          region.leftPartition = subregions.left;
          region.rightPartition = subregions.right;

          let compactRegion = (region) => {
            let leftItems  = subregions.left.items;
            let rightItems = subregions.right.items;
            let intersections = [];
            leftItems.forEach( l => {
              rightItems.forEach(r => {
                // we should memoize these the overlap results somewhere.
                if (l.intersects(r, {onlyVertically: true})) { intersections.push([l,r]); }
              });
            });
            let highestIntersection = 0;
            let lowestIntersection  = 0;
            if (intersections.length > 0) {
              let intersectionTops = intersections.flat().map(i=>i.top);
              let intersectionBottoms = intersections.flat().map(i=>i.bottom);
              //console.log(intersectionTops, intersectionBottoms);
              highestIntersection = Math.min(...intersectionTops);
              lowestIntersection  = Math.max(...intersectionBottoms);
            }
            [region, subregions.left, subregions.right].forEach(reg => reg.setBounds({
              top: highestIntersection,
              bottom: lowestIntersection,
              left: reg.left,
              right: reg.right,
            }, reg.items, reg.obstacles));
          };

          let fontCount = canvas.items.reduce((fonts, item) => {
            fonts[item.fontName] = ((fonts[item.fontName] || 0) + 1);
            return fonts;
          }, {});
          
          //let weightedAverageNumerator = Object.entries(fontCount).reduce((sum, [name,count]) =>{
          //  return sum + ((count) * this.styles[name].spaceWidth);
          //}, 0);
          //let itemCount = Object.values(fontCount).reduce((sum,num)=>sum+num, 0);
          let weightedAverageSpaceWidth = 2; // weightedAverageNumerator / itemCount;

          compactRegion(region);
          let isMeaningfulWhiteSpace = (region.width >= weightedAverageSpaceWidth) && (region.aspectRatio <= 1 );
          if ( isMeaningfulWhiteSpace ){

            let isIdentical = (left, right) => [...left, ...right].every(bool => bool);
            let isDisjoint  = (left, right) => (left.every(bool=>!bool) || right.every(bool=>!bool));
            let isSuperset =  (left, right) => {
              // on the left side...
              // the first region contains all of the second region's items.
              // the second region contains all of the first region's items.
              let [leftFirstContainsSecond, leftSecondContainsFirst] = left;
              let [rightFirstContainsSecond, rightSecondContainsFirst] = right;

              // region's left & right MUST contain all of the elements of
              // space's left & right AND 
              return (leftFirstContainsSecond && rightFirstContainsSecond &&
                      (!leftSecondContainsFirst || !rightSecondContainsFirst));
            };

            let compareRegions = (first, second) => {
              let compareFirstToSecond = [first.leftPartition.compareItems(second.leftPartition),
                                          first.rightPartition.compareItems(second.rightPartition)];
              let compareSecondToFirst = [second.leftPartition.compareItems(first.leftPartition),
                                          second.rightPartition.compareItems(first.rightPartition)];
              return {
                identical: isIdentical(...compareFirstToSecond),
                subset:    isSuperset(...compareSecondToFirst),
                superset:  isSuperset(...compareFirstToSecond),
                disjoint:  isDisjoint(...compareFirstToSecond),
                bools: {
                  compareFirstToSecond: compareFirstToSecond.flat(),
                  compareSecondToFirst: compareSecondToFirst.flat(),
                },
              };
            };

            let drawComparison = (a,b, match) => {
              this.context.clearRect(0,0,this.context.canvas.width, this.context.canvas.height);
              a.drawOnto(this.context, {color: "red"});
              b.drawOnto(this.context, {color: "yellow"});
              console.log(match);
              debugger;
            };

            let drawSets = (candidate, sets) => {
              this.context.clearRect(0,0,this.context.canvas.width, this.context.canvas.height);
              [["supersets", "aqua"], ["subsets", "purple"], ["identical", "yellow"],
               ["disjoint", "lime"], ["other", "grey"]
              ].forEach( ([key, color]) => {
                (sets[key] || []).forEach(item=>item.drawOnto(this.context, {color: color}));
              });
              candidate.drawOnto(this.context, {color: "red" });
              debugger;
            };

            let categorizeSpaces = (buckets, space) => {
              console.log("categorizingSpaces");
              let match = compareRegions(region, space);
              //drawComparison(region, space, match);
                   if ( match.identical ) { buckets.identical.push(space); }
              else if ( match.subset    ) { buckets.supersets.push(space); }
              else if ( match.superset  ) { buckets.subsets.push(space);   }
              else if ( match.disjoint  ) { buckets.disjoint.push(space);  }
              else                        { buckets.other.push(space);     }
              return buckets;
            };
            let matches = whiteSpaces.reduce(categorizeSpaces, 
              { supersets: [], subsets: [], identical: [], disjoint:[], other:[] });

            // clear out all of the items which are subsumed by this region.
            let subsumedByRegion = space => !(matches.subsets.includes(space) || matches.identical.includes(space));
            whiteSpaces = whiteSpaces.filter(subsumedByRegion);

            // then pick the tallest, then widest region that divides items
            // the way this region does.
            let byTallestThenWidest = (a,b)=>{
              if (b.height==a.height){ return b.width - a.width; }
              return b.height-a.height;
            };
            let largestItem = [...matches.identical, region].sort(byTallestThenWidest)[0];

            //drawSets(largestItem, matches);
            // push the element ONLY IF there are no regions which
            // subsume the largest item.
            if (matches.supersets.length == 0) {
              //console.log(matches);
              whiteSpaces.push(largestItem);
            }
          } else {
            //console.log("horizontal", region.aspectRatio);
          }
        }
      };
      regions.forEach(processRegion);
    }
    const orderByTopLeft = (a, b) => {
      // if the y coordinates are the same
      if (a.top == b.top) {
        // determine what the x position is
        return a.left - b.left;
      } else {
        // otherwise just sort these two points based on the y.
        return a.top - b.top;
      }
    };
    const results = whiteSpaces.sort(orderByTopLeft);
    return results;
  },
};

export default MaximalRectangles;