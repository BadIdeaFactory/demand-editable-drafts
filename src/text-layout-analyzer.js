import docx from 'docx';
import FileSaver from 'file-saver';
import Region from './region';

class TextLayoutAnalyzer {
  constructor(text, viewport, context) {
    this.styles   = text.styles;
    this.items    = text.items;
    this.viewport = viewport;
    this.context  = context;
    this.whiteSpace = [];
    this.groups = [];

    this.styleBuf = ['left: ', 0, 'px; top: ', 0, 'px; font-size: ', 0,
      'px; font-family: ', '', ';'];

    let colors = ["Gray", "Black", "Red", "Maroon", "Yellow", "Olive", "Lime", 
                  "Green", "Aqua", "Teal", "Blue", "Navy", "Fuchsia", "Purple"];
    Object.values(this.styles).forEach((style) => {
      let color = colors.splice(Math.floor(Math.random() * colors.length), 1);
      style.color = color;
    });

    this._sorters = {
      orderByTopLeft: (a, b) => {
        // if the y coordinates are the same
        if (a.top == b.top) {
          // determine what the x position is
          return a.left - b.left;
        } else {
          // otherwise just sort these two points based on the y.
          return a.top - b.top;
        }
      },
      orderItemsByTopLeft: (a, b) => {
        // if the y coordinates are the same
        if (a.cssStyles.top == b.cssStyles.top) {
          // determine what the x position is
          return a.cssStyles.left - b.cssStyles.left;
        } else {
          // otherwise just sort these two points based on the y.
          return a.cssStyles.top - b.cssStyles.top;
        }
      },
      orderByLeft: (a, b) => a.cssStyles.left - b.cssStyles.left,
    };

    this.region = this._calculateRegion();
  }

  _calculateRegion() {
    let canvasRegion = new Region(
      { top:  0, bottom: this.context.canvas.height,
        left: 0, right:  this.context.canvas.width,
    });
    return canvasRegion;
  }

  calculateLayout() {
    this.calculateStyles();
    this.findWhiteSpace();
    this.groupRegions();
    return this.region;
  }

  // Cribbed from pdfjs utils
  matrix_transform(m1, m2) {
    return [
      m1[0] * m2[0] + m1[2] * m2[1],
      m1[1] * m2[0] + m1[3] * m2[1],
      m1[0] * m2[2] + m1[2] * m2[3],
      m1[1] * m2[2] + m1[3] * m2[3],
      m1[0] * m2[4] + m1[2] * m2[5] + m1[4],
      m1[1] * m2[4] + m1[3] * m2[5] + m1[5]
    ];
  }

  // Frankensteined together from pdf.js's text_layer.js methods: 
  //   appendText and _layoutText
  calculateItem(item, styles, viewport, context) {
    // This is cribbed from the `appendText` function in text_layer.js
    // START `appendText`
    let textDiv = document.createElement('span');
    let textDivProperties = {
      style: null,
      angle: 0,
      canvasWidth: 0,
      originalTransform: null,
      scale: 1,
    };

    let tx = this.matrix_transform(viewport.transform, item.transform);
    // 
    let angle = Math.atan2(tx[1], tx[0]);
    let style = styles[item.fontName];
    if (style.vertical) { angle += Math.PI / 2; }
    // i'm still not clear what tx[2] and tx[3] represent.
    let fontHeight = Math.sqrt((tx[2] * tx[2]) + (tx[3] * tx[3]));
    // assume the that the font's ascenders are equal to the font height.
    let fontAscent = fontHeight;
    if (style.ascent) {
      // if the ascent is specified in the styles, scale the fontAscent
      // by the style's ascent
      fontAscent = style.ascent * fontAscent;
    } else if (style.descent) {
      // otherwise if the descent is specified modify by that.
      fontAscent = (1 + style.descent) * fontAscent;
    }

    let left;
    let top;
    if (angle === 0) {
      // if the text isn't rotated...
      left = tx[4];               // the left bound is tx[4]
      top = tx[5] - fontAscent;   // the top bound is tx[5] discounted by the fontAscent
    } else {
      // tx[4] plus the height of the element modified by the angle.
      // so for example, if angle is 90°, it's sine is 1.
      // Thus left is tx[4] + fontAscent
      // if angle is 45°, left is `tx[4] + (fontAscent * 0.5)`
      left = tx[4] + (fontAscent * Math.sin(angle));
      // Likewise if angle is 90° top is `tx[5] - (fontAscent * 0)`
      // and if angle is 0° top is `tx[5] - (fontAscent * 1)`
      // and if angle is 45° top is `tx[5] - (fontAscent * 0.5)`
      top = tx[5] - (fontAscent * Math.cos(angle));
      // So if we think about this basically, when a rotation happens with positive THETA
      // the element is rotated around its center, and the LEFT edge of the boundary increases 
      // by some fraction of the height+ascent of the text element.
      //
      // The BOTTOM LEFT corner must be moved further to the right
      // such that the TOP LEFT corner sits at tx[4] as it swings back to the left.
      // 
      // Likewise, as the TOP RIGHT corner swings UPWARD, the `top` field must be diminished
      // by the appropriately rotated fraction of the fontAscent so that the TOP RIGHT corner
      // sits at tx[5].
    }
    this.styleBuf[1] = left;
    textDivProperties.left = left;

    this.styleBuf[3] = top;
    textDivProperties.top = top;

    this.styleBuf[5] = fontHeight;
    textDivProperties.fontHeight = fontHeight;

    this.styleBuf[7] = style.fontFamily;
    textDivProperties.fontFamily = style.fontFamily;

    textDivProperties.style = this.styleBuf.join('');
    textDiv.setAttribute('style', textDivProperties.style);

    textDiv.textContent = item.str;
    // `fontName` is only used by the FontInspector, and we only use `dataset`
    // here to make the font name available in the debugger.
    /*if (task._fontInspectorEnabled) {
      textDiv.dataset.fontName = item.fontName;
    }*/
    if (angle !== 0) {
      textDivProperties.angle = angle * (180 / Math.PI);
    }
    if (style.vertical) {
      textDivProperties.canvasWidth = item.height * viewport.scale;
    } else {
      textDivProperties.canvasWidth = item.width * viewport.scale;
    }
    // END `appendText`
    // START `_layoutText`

    let fontSize = textDiv.style.fontSize;
    let fontFamily = textDiv.style.fontFamily;

    // pdf.js batches this and only set the font
    // if it differs between two text elements
    context.font = `${fontSize} ${fontFamily}`;
    let width = context.measureText(textDiv.textContent).width;
    textDivProperties.width = width;
    style.spaceWidth = context.measureText(" ").width;
    style.fontHeight = fontHeight;

    let transform = '';

    if (textDivProperties.canvasWidth !== 0 && width > 0) {
      //// the scale is equal to the proportion of the `canvasWidth` to the calculated `width`
      textDivProperties.scale = textDivProperties.canvasWidth / width;
      transform = `scaleX(${textDivProperties.scale})`;
    }
    //// rotate the text as needed.
    if (textDivProperties.angle !== 0) {
      transform = `rotate(${textDivProperties.angle}deg) ${transform}`;
    }
    //// set the transform into the styles if there are any.
    if (transform.length > 0) {
      textDivProperties.originalTransform = transform;
      textDivProperties.style = `${textDivProperties.style} transform: ${transform};`;
      textDiv.style.transform = transform;
    }

    textDiv.classList.add(item.fontName);
    textDiv.style.borderColor = style.color;
    item.element = textDiv;
    // what i want: left, top, angle, scale, height, width, font-size, font-family
    return textDivProperties;
  }

  calculateStyles() {
    // text should be the result of `page.getTextContent`
    this.items.forEach((item) => {
      item.cssStyles = this.calculateItem(item, this.styles, this.viewport, this.context);
    });
    return { items: this.items, styles: this.styles };
  }

  appendTextElementsTo(textLayer) {
    this.groupTextIntoLines();
    this.groups.forEach((group) => {
      group.items.forEach((item) => textLayer.appendChild(item.element));
    });
  }

  sort() { return this.items.sort(this._sorters["orderItemsByTopLeft"]); }

  mergeSmallCaps(items) {
    let regions = items.map((item) => {let region = new Region(item); region.item = item; return region; });
    // if regions are adjacent and share a font, and are smallcaps, merge them into a single region.

    // share a y position and are w/in some boundary of adjacency
    
    // get all of the strings that are all caps.
    let allCaps = regions.filter((region)=>{
      return region.item.str.match(/^([A-Z]|\W)*[A-Z]([A-Z]|\W)*$/);
    });

    // next we find the elements that are adjacent to them
    let capsLines = allCaps.map((caps)=>{
      let capsSpaceWidth = this.styles[caps.item.fontName].spaceWidth;
      let sameLine = (a, b) => {
        let extendedToBorder = new Region({ 
          top: a.top, 
          bottom: a.bottom, 
          left: 0, 
          right: this.context.canvas.width
        });
        return extendedToBorder.intersects(b);
      };
      let capsLineRegions = regions.filter((region) => {
        return (
          region.item.fontName == caps.item.fontName &&
          sameLine(caps, region)
        );
      });
      let capsLineBoundaries = capsLineRegions.reduce((lineBounds, region) => {
        return {
          top    : (lineBounds.top)    ? Math.min(lineBounds.top, region.top)       : region.top,
          bottom : (lineBounds.bottom) ? Math.max(lineBounds.bottom, region.bottom) : region.bottom,
          left   : (lineBounds.left)   ? Math.min(lineBounds.left, region.left)     : region.left,
          right  : (lineBounds.right)  ? Math.max(lineBounds.right, region.right)   : region.right,
        };
      }, {});
      let capsLine = new Region(capsLineBoundaries, items);
      if (!capsLineRegions.every(region=>capsLine.contains(region))) { debugger; }
      capsLine.drawOnto(this.context);
      return capsLine;
    });

    let capsItems = capsLines.reduce((list, line) => list.concat(line.items), []);
    let result = capsLines.concat(regions.filter(region => !capsItems.includes(region.item)));
    return result.sort(this._sorters.orderByTopLeft);
  }

  appendWhiteSpaceTo(textLayer) {
    this.findWhiteSpace();
    let spaceContainer = document.createElement("div");
    this.whiteSpaces.forEach((space)=>{
      let el = document.createElement("span");
      el.setAttribute('style', 
      `left: ${space.left}px; top: ${space.top}px; width: ${space.width}px; height: ${space.height}px;`);
      spaceContainer.appendChild(el);
      space.element = el;
    });
    textLayer.appendChild(spaceContainer);
  }

  findWhiteSpace() {
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

    let items = this.sort();
    let mergedItems = this.mergeSmallCaps(items);

    // turn all of the items into bounding boxes
    // defined by their css measured dimensions.
    let elements = mergedItems.map((item) => new Region(item));

    // We're using the canvas as the initial bounding box.
    let canvasBounds = new Region({ top: 0, bottom: this.context.canvas.height,
                                    left: 0, right: this.context.canvas.width,}, elements);

    let queue = [canvasBounds];
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
          let subregions = canvasBounds.intersectingPartition(region, ['left','right']);
          region.leftPartition = subregions.left;
          region.rightPartition = subregions.right;
          // we should memoize these results somewhere.
          let itemsOverlap = (a, b) => !(a.bottom < b.top || a.top > b.bottom);

          let compactRegion = (region) => {
            let leftItems  = subregions.left.items;
            let rightItems = subregions.right.items;
            let intersections = [];
            leftItems.forEach( l => {
              rightItems.forEach(r => {
                if (itemsOverlap(l,r)) { intersections.push([l,r]); }
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

          let fontCount = items.reduce((fonts, item) => {
            fonts[item.fontName] = ((fonts[item.fontName] || 0) + 1);
            return fonts;
          }, {});
          
          let weightedAverageNumerator = Object.entries(fontCount).reduce((sum, [name,count]) =>{
            return sum + ((count) * this.styles[name].spaceWidth);
          }, 0);
          let itemCount = Object.values(fontCount).reduce((sum,num)=>sum+num, 0);
          let weightedAverageSpaceWidth = weightedAverageNumerator / itemCount;

          compactRegion(region);
          let isMeaningfulWhiteSpace = !( region.width < weightedAverageSpaceWidth || region.aspectRatio > 1 );
          if ( isMeaningfulWhiteSpace ){  
            // this is causing troubles.

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
              else if ( match.superset  ) { buckets.subsets.push(space);   }
              else if ( match.subset    ) { buckets.supersets.push(space); }
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
    this.whiteSpaces = whiteSpaces.sort(this._sorters.orderByTopLeft);
    this.region.setObstacles(this.whiteSpaces);
    return this.whiteSpaces;
  }

  groupRegions() {
    // wtf why isn't items set already.
    // this needs to be called after calculateStyles called so that
    // the items have defined offsetWidth, offsetHeight, offsetTop and offsetLeft
    let itemRegions = this.items.map(i => {let r = new Region(i); r.item = i; return r;});
    this.region.setItems(itemRegions);
    this.regions = this.region.partitionByObstacles();
  }

  groupTextIntoLines() {
    // if multiple elements overlap in the Y direction
    // we should calculate whether all of the chunks belong together.
    //
    // what's an overlap in the Y direction?
    // numbers: a.top, a.fontHeight, b.top, b.fontHeight

    // each group has a top and a bottom bound which is the accumulation of
    // the bounds of all of its elements.
    this.groups = [];
    let candidates = this.sort();  // sort elements based on each top left corner
    let alreadyGrouped = [];

    candidates.forEach((item) => {
      if (!alreadyGrouped.includes(item)) {
        // seed the overlap with the initial element
        let overlap = {
          top: item.cssStyles.top,
          bottom: item.cssStyles.top + item.cssStyles.fontHeight,
          items: [item],
        };
        alreadyGrouped.push(item);

        let elementsOverlap = (a, b) => !(a.bottom < b.top || a.top > b.bottom);

        // loop through all of the items
        candidates.forEach((second) => {
          let secondBounds = {
            top: second.cssStyles.top,
            bottom: second.cssStyles.top + second.cssStyles.fontHeight
          };

          // check to make sure the element hasn't already been included
          if (!alreadyGrouped.includes(second) && elementsOverlap(overlap, secondBounds)) {
            overlap.items.push(second);
            alreadyGrouped.push(second);
            overlap.top = Math.min(overlap.top, secondBounds.top);
            overlap.bottom = Math.max(overlap.bottom, secondBounds.bottom);
          }

        });

        overlap.items = overlap.items.sort(this._sorters.orderByLeft);
        overlap.text = overlap.items.map((i) => i.str);
        this.groups.push(overlap);
      }
    });

    return this.groups;
  }

  mungeLine(line){
    return line.replace(/‘‘/g, '“')
               .replace(/’’/g, '”')
               .replace(/\s+/, ' ');
  }

  async dumpDocX() {
    let doc = new docx.Document();
    let paragraph = new docx.Paragraph(this.dumpText());
    doc.addParagraph(paragraph);

    let packer = new docx.Packer();
    let docBuffer = await packer.toBuffer(doc);
    let blob = new Blob(
      [docBuffer], 
      {type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'}
    );
    FileSaver.saveAs(blob, "derp.docx");
  }

  appendTextToDocX(doc, options={}) {
    let text = this.dumpText();
    console.log(text);
    let paragraph = new docx.Paragraph(text);
    if (!options.noPageBreak){ paragraph.pageBreakBefore(); }
    doc.addParagraph(paragraph);
  }
}

export default TextLayoutAnalyzer;