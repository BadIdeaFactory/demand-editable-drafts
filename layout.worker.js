(function () {
  'use strict';

  class Action {
    constructor(job_id, data={}, options={}){
      this.job_id  = job_id;
      this.data    = data;
      this.options = options;

      this.callbacks = {
        start:    (this.options.start    || []),
        complete: (this.options.complete || []),
      };
    }

    async start(){
      if (this.callbacks.start.length > 0) {
        this.callbacks.start.forEach(cb => cb(float, message));
      }
      if (self.debug) { console.log(`Started Job (${this.constructor.name} | ${this.job_id})`); }
      const result = await this.process(this.data);
      this.complete(result);
      return result;
    }

    async process() { throw "please implement process"; }

    complete(result) {
      this.status = 'complete';
      if (self.debug) { console.log(`Completed Job (${this.constructor.name} | ${this.job_id})`); }
      this.send(result);
      if (this.callbacks.complete.length > 0){
        this.callbacks.complete.forEach(cb => cb(result));
      }
    }

    progress(float, message){ 
      if (float < 0 || float > 1) { throw `Progress (${float}) must be a float between 0 and 1.`; }
      if (this.options.progress) {
        this.send({progress: float, message: message});
      }
    }

    send(msgData){
      self.postMessage({
        job_id: this.job_id,
        action: this.constructor.name,
        data: msgData,
      });
    }
  }

  class LolAction extends Action {
    async process() {
      this.progress(0, `Started Job (${this.constructor.name} | ${this.job_id})`);
      const items = [1,2,3,4];
      const sleep = m => new Promise(r => setTimeout(r, m));
      const startTime = new Date();
      for (const [index, item] of items.entries()) {
        await sleep(500);
        this.progress((index+1)/items.length);
      }
      const completeTime = new Date();

      return {
        job_id: this.job_id,
        action: name,
        data: { 
          message: `Acknowledging message. \n\tStarted at: ${startTime}\n\tCompleted at: ${completeTime}`,
          startTime: startTime,
          completeTime: completeTime,
        },
      };
    }
  }

  const PDFUtils = {
    // Cribbed from pdfjs utils
    matrix_transform: (m1, m2) => {
      return [
        m1[0] * m2[0] + m1[2] * m2[1],
        m1[1] * m2[0] + m1[3] * m2[1],
        m1[0] * m2[2] + m1[2] * m2[3],
        m1[1] * m2[2] + m1[3] * m2[3],
        m1[0] * m2[4] + m1[2] * m2[5] + m1[4],
        m1[1] * m2[4] + m1[3] * m2[5] + m1[5]
      ];
    }
  };

  /*
    `TextItem` is the connector between PDFJS+DOM and the layout calculation system.
    
  */

  class TextItem {
    constructor(data, styles) {
      this.data = data;
      this.text = data.str;
      this.documentStyles = styles;
      this.fontName = this.data.fontName;
      this.fontStyle = this.documentStyles[this.data.fontName];
      this.fontFamily = this.fontStyle.fontFamily;
      this.styles = {
        fontName: this.fontName,
        fontFamily: this.fontFamily,
        fontStyle: this.fontStyle
      };
    }

    // Frankensteined together from pdf.js's text_layer.js methods: 
    //   appendText and _layoutText
    calculateDimensions(vpTransform, vpScale){
      const style = this.fontStyle;
      const tx = PDFUtils.matrix_transform(vpTransform, this.data.transform);
      
      let angle = Math.atan2(tx[1], tx[0]);
      if (style.vertical) { angle += Math.PI / 2; }

      // i'm still not clear what tx[2] and tx[3] represent.
      const fontHeight = Math.sqrt((tx[2] * tx[2]) + (tx[3] * tx[3]));
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

      if (angle !== 0) { this.degrees =  angle * (180 / Math.PI); }
      const scaledItemWidth = ((style.vertical) ? this.data.height : this.data.width) * vpScale;
      
      let left, top; 
      if (angle === 0) {
        // if the text isn't rotated...
        left   = tx[4];               // the left bound is tx[4]
        top    = tx[5] - fontAscent;   // the top bound is tx[5] discounted by the fontAscent
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

      this.fontHeight = fontHeight;
      this.styles.fontSize = fontHeight;
      this.height = fontHeight;
      this.width  = scaledItemWidth;
      this.angle  = angle;

      this.left   = left;
      this.top    = top;
      // hmmmmm. these should probably also factor in the angle like we're doing with the left/top.
      this.bottom = this.top  + this.height;
      this.right  = this.left + this.width;

      // Match Region
      this.center = this.findCenter();
      this.aspectRatio = this.width / this.height;
      this.area = this.width*this.height;

      return this;
    }

    // Frankensteined together from pdf.js's text_layer.js methods: 
    //   appendText and _layoutText
    cssAttributes(context){
      let textWidth = null;
      let scale = null;
      let transform;
      let originalTransform;
      let transformString;

      if (context) {
        context.font = `${this.height}px ${this.fontFamily}`;
        textWidth = context.measureText(this.data.str).width;
        scale = this.width / textWidth;
        transform = `scaleX(${scale})`;
      }
      if (this.angle !== 0) {
        transform = `rotate(${this.degrees}deg) ${transform}`;
      }
      originalTransform = transform;
      transformString = `transform: ${transform};`;

      const css = {
        angle: this.angle,
        canvasWidth: this.width,
        fontFamily: this.fontFamily,
        fontHeight: this.height,
        left: this.left,
        originalTransform: originalTransform,
        transform: transformString,
        scale: scale,
        top: this.top,
        width: textWidth,
      };
      css.style = `left: ${this.left}px; top: ${this.top}px; font-size: ${this.height}px; font-family: ${this.fontFamily}; ${transformString}`;
      return css;
    }

    // Cribbed from Region
    findCenter() {
      return {
        x: (this.right  - this.left)/2 + this.left,
        y: (this.bottom - this.top)/2 + this.top
      };
    }

    // Cribbed from Region.
    intersects(region, options={}) {
      // We can rely on the fact that each region's `right` > `left` and `bottom` > `top`.
      // So, we can grab the boundaries closest to the opposite edge for each dimension
      let furthestLeft  = Math.max(this.left, region.left);
      let nearestRight  = Math.min(this.right, region.right);
      let lowestTop     = Math.max(this.top, region.top);
      let highestBottom = Math.min(this.bottom, region.bottom);
      // and then make sure that the boundaries overlap.
      const intersectsHorizontally = furthestLeft < nearestRight;
      const intersectsVertically   = lowestTop < highestBottom;
      let result;
      if (options.onlyVertically) {
        result = intersectsVertically;
      } else if (options.onlyHorizontally) {
        result = intersectsHorizontally;
      } else {
        result = intersectsHorizontally && intersectsVertically;
      }
      return result;
    }

    getText() { return this.text; }
    getStyles() { return this.styles; }
  }

  class Region {
    constructor(params, items=[], obstacles=[]) {
      let keys = Object.keys(params);
      let bounds;
      if (keys.includes('cssStyles')) {
        let style = params.cssStyles;
        bounds = {
          top:    style.top,
          bottom: style.top + style.fontHeight,
          left:   style.left,
          right:  style.left + style.width*(style.scale||1)
        };
        this.item = params;
      } else if (['top', 'bottom', 'left', 'right'].every( key => keys.includes(key) )) {
        bounds = {
          top:    params.top,
          bottom: params.bottom,
          left:   params.left,
          right:  params.right,
        };
      } else {
        // lol error
        throw "Invalid parameters (params must be an object w/ top,bottom,left,right or have an html `element`)";
      }

      this.setBounds(bounds, items, obstacles);
      this.regions = {};
      //if (this.width < 0 || this.height < 0) { debugger; }
    }

    setBounds(bounds, items=[], obstacles=[]){
      ['top', 'bottom', 'left', 'right'].forEach(key => {
        let value = bounds[key];
        if ((typeof value) == 'string') { value = Number.parseFloat(value); }
        this[key] = value; // Math.floor(value);
      });
      this.calculateData();
      if (items) { this.setItems(items); }
      if (obstacles) { this.setObstacles(obstacles); }
    }

    calculateData() {
      this.center = this.findCenter();
      this.width = this.right - this.left;
      this.height = this.bottom - this.top;
      this.aspectRatio = this.width / this.height;
      this.area = this.width*this.height;
    }

    isEmpty() {
      return this.items.length == 0;
    }

    setItems(candidates) {
      this.items = candidates.filter(el => this.intersects(el));
      const getStyles = (fonts, obj) => {
        if (obj instanceof Region && obj.fonts.size > 0){
          obj.fonts.forEach(font => fonts.add(font));
        } else if (obj instanceof TextItem) {
          const fontName = obj.fontName;
          fonts.add(fontName);
        } else {
          debugger;
          throw '¯\_(ツ)_/¯';
        }
        return fonts;
      };
      this.fonts = this.items.reduce(getStyles, new Set());
    }

    compareItems(other) {
      let otherHasEveryItem = this.items.every(item => other.items.includes(item));
      let thisHasOtherItems = other.items.every(item => this.items.includes(item));

      return [thisHasOtherItems, otherHasEveryItem];
    }

    setObstacles(candidates) {
      this.obstacles = candidates.filter(space => this.intersects(space));
    }

    // The center of a rectangle is the midpoint of the edges.
    findCenter() {
      return {
        x: (this.right  - this.left)/2 + this.left,
        y: (this.bottom - this.top)/2 + this.top
      };
    }

    // Since this algorithm is a divide & conquer search
    // it recommends starting with a candidate element
    // that will divide the space most effectively.
    //
    // So finding the pivot element will just be identifying
    // the element with its center closest to the bounding box's.
    findPivot(){
      // grab the first element
      let mostCentered;
      this.items.forEach((item)=>{
        let candidateDistance = Math.hypot(
          item.center.x - this.center.x, 
          item.center.y - this.center.y
        );
        item.center.distanceToBoundsCenter = candidateDistance;
        if (!mostCentered || candidateDistance < mostCentered.center.distanceToBoundsCenter ) {
          mostCentered = item;
        }
      });
      return mostCentered;
    }

    // This segments this region into (up to) four subregions which intersect
    // with the obstacle along one axis.
    intersectingPartition(obstacle, keys=['top', 'bottom', 'left', 'right']) {
      if (!['top', 'bottom', 'left', 'right'].every(key => Object.keys(obstacle).includes(key))) {
        throw "obstacle must have `top`, `bottom`, `left` and `right` keys";
      }
      let regions = {};
      let bounds = {
        top:    { top:  this.top,        bottom: obstacle.top, 
                  left: obstacle.left,   right:  obstacle.right},
        bottom: { top:  obstacle.bottom, bottom: this.bottom, 
                  left: obstacle.left,   right:  obstacle.right},
        left:   { top:  obstacle.top,    bottom: obstacle.bottom,
                  left: this.left,       right:  obstacle.left,},
        right:  { top:  obstacle.top,    bottom: obstacle.bottom,
                  left: obstacle.right,  right:  this.right,   },
      };

      keys.forEach(key => regions[key] = new Region(bounds[key], this.items, this.obstacles) );
      return regions;
    }
    
    // This segments this region into (up to) four overlapping subregions which bound
    // the obstacle.
    partition(obstacle, keys=['top', 'bottom', 'left', 'right']) {
      if (!['top', 'bottom', 'left', 'right'].every(key => Object.keys(obstacle).includes(key))) {
        throw "obstacle must have `top`, `bottom`, `left` and `right` keys";
      }
      let regions = {};
      let bounds = {
        top:    { top:  this.top,        bottom: obstacle.top, 
                  left: this.left,       right:  this.right    },
        bottom: { top:  obstacle.bottom, bottom: this.bottom, 
                  left: this.left,       right:  this.right    },
        left:   { top:  this.top,        bottom: this.bottom,
                  left: this.left,       right:  obstacle.left,},
        right:  { top:  this.top,        bottom: this.bottom,
                  left: obstacle.right,  right:  this.right,   },
      };

      keys.forEach(key => regions[key] = new Region(bounds[key], this.items, this.obstacles) );
      return regions;
    }

    // This recursively partitions this region into non-overlapping subregions
    // divided by obstacles.
    partitionByObstacles() {
      if (this.obstacles.length > 0) {
        // We're making the assumption that this document is read top-to-bottom
        // so we're partitioning around each obstacle into a top region
        // left and right of the obstacle, and then a region below the region
        // none of which overlap.
        this.regions = {};
        [Object.entries(this.partition(this.obstacles[0], ['top', 'bottom'])), 
         Object.entries(this.intersectingPartition(this.obstacles[0], ['left', 'right']))
        ].flat().map(([key,value])=> this.regions[key] = value);
      } else {
        this.regions = {};
      }
      // ask each of the regions to partition themselves.
      Object.values(this.regions).forEach(region => region.partitionByObstacles());
      return this.regions;
    }

    equalBounds(region) {
      return (
        this.top == region.top &&
        this.bottom == region.bottom &&
        this.left == region.left &&
        this.right == region.right
      );
    }

    intersects(region, options={}) {
      // We can rely on the fact that each region's `right` > `left` and `bottom` > `top`.
      // So, we can grab the boundaries closest to the opposite edge for each dimension
      let furthestLeft  = Math.max(this.left, region.left);
      let nearestRight  = Math.min(this.right, region.right);
      let lowestTop     = Math.max(this.top, region.top);
      let highestBottom = Math.min(this.bottom, region.bottom);
      // and then make sure that the boundaries overlap.
      const intersectsHorizontally = furthestLeft < nearestRight;
      const intersectsVertically   = lowestTop < highestBottom;
      let result;
      if (options.onlyVertically) {
        result = intersectsVertically;
      } else if (options.onlyHorizontally) {
        result = intersectsHorizontally;
      } else {
        result = intersectsHorizontally && intersectsVertically;
      }
      return result;
    }

    contains(region){
      return (Math.min(region.top, this.top) == this.top &&
              Math.max(region.bottom, this.bottom) == this.bottom &&
              Math.min(region.left, this.left) == this.left &&
              Math.max(region.right, this.right) == this.right);
    }

    overlap(region) {
      let result;
      if (this.intersects(region)) {
        return new Region({ 
          top:    Math.max(region.top, this.top),
          bottom: Math.min(region.bottom, this.bottom),
          left:   Math.max(region.left, this.left),
          right:  Math.min(region.right, this.right)
        });
      }
      return result;
    }

    drawOnto(context, style={}){
      context.strokeStyle = (style.color || "blue");
      context.setLineDash([6]);
      context.strokeRect(this.left, this.top, this.width, this.height);
    }

    walk(fn, options={}) {
      if (!fn) { return; }
      const defaultWalker = (region, processor) => {
        const results = [];
        if (!region.regions) { console.log(region); }
        if (Object.keys(region.regions).length > 0) {
          const orderedKeys = ['top', 'left', 'right', 'bottom'];
          const regions = orderedKeys.map(key=>region.regions[key]);
          regions.forEach((r) => results.push(defaultWalker(r,processor)));
        } else {
          results.push(processor(region));
        }
        return results;
      };

      let walker = (options.customWalker ? options.customWalker : defaultWalker);
      return walker(this, fn);
    }

    groupItems() {
      let groupByLine = (lines, item) => {
        let overlap = lines.find(line =>{ 
          return line.intersects(item) && line.items.every(i => i.angle == item.angle);
        });
        if (!overlap || item.degrees) {
          overlap = new Region({
            top: item.top,
            bottom: item.bottom,
            left: 0,
            right: this.right,
          }, [item]);
          lines.push(overlap);
        } else {
          overlap.setBounds({
            top: Math.min(overlap.top, item.top),
            bottom: Math.max(overlap.bottom, item.bottom),
            left: 0,
            right: this.right,
          }, [...overlap.items, item]);
        }
        return lines;
      };

      let items = this.items.sort((a,b)=>b.height-a.height);
      let lines = items.reduce(groupByLine, []);
      lines.forEach(line => {
        const leftmost = line.items.sort((a,b)=>a.left-b.left)[0];
        line.setBounds({
          top: line.top,
          bottom: line.bottom,
          left: leftmost.left,
          right: line.right,
        }, line.items);
      });
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
      return lines.sort(orderByTopLeft);
    }

    getText(options={}) {
      const defaultJoinLine = (line)=> {
        return line.items.sort((a,b)=>a.left-b.left).map( r => r.text ).join(' ');
      };
      let processLine = defaultJoinLine;
      if (options.line) { processLine = options.line; }

      let text;
      if (this.item) {
        text = this.text;
      } else {
        let textLines = this.walk((region) => {
          let lines = region.groupItems(); 
          return lines.map( line => processLine(line)).join("\n");
        });
        text = textLines.join("\n");
      }
      return text;
    }
  }

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

              let categorizeSpaces = (buckets, space) => {
                //console.log("categorizingSpaces");
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

  class PageLayoutAnalyzer {
    constructor(text, viewportTransform, viewportScale, width, height, options={}) {
      const initialize = (text, viewportTransform, viewportScale, width, height, options) => {
        this.pdfjsData = text;
        this.styles    = text.styles;
        this.items     = text.items.map(item => new TextItem(item, this.styles));
        this.transform = viewportTransform;
        this.scale     = viewportScale;
        // these are the canvas width & height in px.
        this.width = width;
        this.height = height;
        this.bounds = { left: 0, top: 0, bottom: this.height, right: this.width, };
    
        this.whiteSpaces = [];
        this.groups = [];
        this.region = this._calculateRegion(); 
      };

      if (options.rehydrate && options.data) {
        this.rehydrate(options.data);
      } else {
        initialize(text, viewportTransform, viewportScale, width, height);
      }
    }

    rehydrate(data) {
      Object.entries(data).forEach(([key, value]) => {
        this[key] = value;
      });
      const itemRehydrator = itemData => { 
        const item = new TextItem(itemData.data, itemData.documentStyles);
        Object.entries(itemData).forEach(([key, value]) => {
          item[key] = value;
        });
        return item;
      };
      this.items = this.items.map(itemRehydrator);

      const obstacles = data.region.obstacles;
      const regionRehydrator = (regionData) => {
        const bounds = {
          left: regionData.left, 
          top: regionData.top, 
          bottom: regionData.bottom, 
          right: regionData.right,
        };
        const region = new Region(bounds, this.items, obstacles);

        Object.entries(regionData.regions).forEach(([key, subRegion]) => {
          const subRegionData = subRegion;
          subRegionData.items = this.items;
          subRegionData.obstacles = obstacles;
          region.regions[key] = regionRehydrator(subRegionData);
        });
        return region;
      };
      this.region = regionRehydrator(data.region);
    }

    orderByTopLeft(a,b){
      // if the y coordinates are the same
      if (a.top == b.top) {
        // determine what the x position is
        return a.left - b.left;
      } else {
        // otherwise just sort these two points based on the y.
        return a.top - b.top;
      }
    }

    _calculateRegion() {
      this._calculateStyles();
      let canvasRegion = new Region(this.bounds, this.items);
      return canvasRegion;
    }

    calculateLayout(options={}) {
      if (!this.calculatedLayout || options.force){
        this._calculateStyles();
        this._calculateWhiteSpace();
        this.groupRegions();
        this.calculatedLayout = true;
      }
      return this;
    }

    _calculateStyles() {
      this.items.forEach(item => item.calculateDimensions(this.transform, this.scale) );
      return { items: this.items, styles: this.styles };
    }

    _calculateWhiteSpace(){
      let elements = this.mergeLines();
      // We're using the canvas as the initial bounding box.
      const canvas = new Region(this.bounds, elements);
      this.whiteSpaces = MaximalRectangles.findWhiteSpace(canvas);
      return this.whiteSpaces;
    }

    groupRegions() {
      // this needs to be called after _calculateStyles called so that
      // the items have defined offsetWidth, offsetHeight, offsetTop and offsetLeft
      this.region.setItems(this.items);
      this.region.setObstacles(this.whiteSpaces);
      this.region.partitionByObstacles();
    }

    sort() { return this.items.sort(this.orderByTopLeft); }

    mergeLines(){
      /* let regionItems = this.sort().map(item=>{
        let region = new Region(item); 
        region.item = item; 
        return region;
      }); */
      let itemRegions = this.sort().map(data => new TextItem(data, this.styles));
      itemRegions = this.items;
      
      // get all of the strings that are all caps.
      let allCaps = itemRegions.filter((item)=>{
        return item.text.match(/^([A-Z]|\W)*[A-Z]([A-Z]|\W)*$/);
      });

      let merge = (caps) => {
        // Find any items which overlap vertically with `caps`
        const sameLine = (a, b) => {
          const opts = (a.degrees && a.degrees == 90) ? {onlyHorizontally: true} : {onlyVertically: true} ;
          return a.intersects(b, opts);
        };
        const capsLineRegions = itemRegions.filter((item) => {
          //debugger;
          return (item === caps || ( item.fontName == caps.fontName && sameLine(caps, item)));
        });

        // get the expanded boundaries
        const capsLineBoundaries = capsLineRegions.reduce((lineBounds, item) => {
          return {
            top    : (lineBounds.top)    ? Math.min(lineBounds.top, item.top)       : item.top,
            bottom : (lineBounds.bottom) ? Math.max(lineBounds.bottom, item.bottom) : item.bottom,
            left   : (lineBounds.left)   ? Math.min(lineBounds.left, item.left)     : item.left,
            right  : (lineBounds.right)  ? Math.max(lineBounds.right, item.right)   : item.right,
          };
        }, {});
        const capsLine = new Region(capsLineBoundaries, capsLineRegions);
        capsLine.hasSmallCaps = true;
        if (!capsLineRegions.every(region=>capsLine.contains(region))) { debugger; }
        //capsLine.drawOnto(this.context);
        return capsLine;
      };

      // next we find the elements that are adjacent to them
      let capsLines = allCaps.map(merge);
      let countedItems = capsLines.map(line => line.items).flat();
      let unaccountedItems = itemRegions.filter(i => !countedItems.includes(i));
      let resultItems = [...countedItems,...unaccountedItems];
      let allItems = itemRegions;
      const identical = (arr1, arr2) => arr1.every(i=>arr2.includes(i)) && arr2.every(i=>arr1.includes(i));
      if (!(identical(allItems,resultItems) && identical(allItems, this.items))) { debugger; }
      let unaccountedItemRegions = itemRegions.filter( r => unaccountedItems.includes(r));
      let result = [...capsLines, ...unaccountedItemRegions].sort(this.orderByTopLeft);
      //this.region.setItems(result);
      return result;
    }

    appendTextElementsTo(textLayer, context) {
      this.calculateLayout();
      const colors = ["Gray", "Black", "Red", "Maroon", "Yellow", "Olive", "Lime", 
      "Green", "Aqua", "Teal", "Blue", "Navy", "Fuchsia", "Purple"];
      const colorMap = Object.keys(this.styles).reduce((buckets, fontName) => {
        let color = colors.splice(Math.floor(Math.random() * colors.length), 1);
        buckets[fontName] = color[0];
        return buckets;
      }, {});

      this.region.walk((region) => {
        let lines = region.groupItems();
        lines.forEach(line => {
          line.items.sort((a,b)=>a.left-b.left).map(item =>{ 
            const element = document.createElement('span');
            const itemStyles = item.cssAttributes(context);
            element.setAttribute('style', itemStyles.style);
            element.textContent = item.text;
            textLayer.appendChild(element);
          });
        });
      });
    }

    appendWhiteSpaceTo(textLayer) {
      this.calculateLayout();
      let spaceContainer = document.createElement("div");
      this.whiteSpaces.forEach((space)=>{
        let el = document.createElement("span");
        el.className = "whitespace";
        el.setAttribute('style', 
        `left: ${space.left}px; top: ${space.top}px; width: ${space.width}px; height: ${space.height}px;`);
        spaceContainer.appendChild(el);
        space.element = el;
      });
      textLayer.appendChild(spaceContainer);
    }
  }

  class PageLayoutAction extends Action {
    process({text, vpTransform, vpScale, width, height}){
      const analyzer = new PageLayoutAnalyzer(text, vpTransform, vpScale, width, height);
      this.progress(0, `Calculating Item Styles`);
      analyzer._calculateStyles();
      this.progress(0.33, `Calculating White Space`);
      analyzer._calculateWhiteSpace();
      this.progress(0.66, `Segmenting Regions`);
      analyzer.groupRegions();
      analyzer.calculatedLayout = true;
      this.progress(1, `Done`);
      return analyzer;
    }
  }

  function isPromise (obj) {
    // via https://unpkg.com/is-promise@2.1.0/index.js
    return !!obj && (typeof obj === 'object' || typeof obj === 'function') && typeof obj.then === 'function'
  }

  function registerPromiseWorker (callback) {
    function postOutgoingMessage (e, messageId, error, result) {
      function postMessage (msg) {
        /* istanbul ignore if */
        if (typeof self.postMessage !== 'function') { // service worker
          e.ports[0].postMessage(msg);
        } else { // web worker
          self.postMessage(msg);
        }
      }
      if (error) {
        /* istanbul ignore else */
        if (typeof console !== 'undefined' && 'error' in console) {
          // This is to make errors easier to debug. I think it's important
          // enough to just leave here without giving the user an option
          // to silence it.
          console.error('Worker caught an error:', error);
        }
        postMessage([messageId, {
          message: error.message
        }]);
      } else {
        postMessage([messageId, null, result]);
      }
    }

    function tryCatchFunc (callback, message) {
      try {
        return { res: callback(message) }
      } catch (e) {
        return { err: e }
      }
    }

    function handleIncomingMessage (e, callback, messageId, message) {
      var result = tryCatchFunc(callback, message);

      if (result.err) {
        postOutgoingMessage(e, messageId, result.err);
      } else if (!isPromise(result.res)) {
        postOutgoingMessage(e, messageId, null, result.res);
      } else {
        result.res.then(function (finalResult) {
          postOutgoingMessage(e, messageId, null, finalResult);
        }, function (finalError) {
          postOutgoingMessage(e, messageId, finalError);
        });
      }
    }

    function onIncomingMessage (e) {
      var payload = e.data;
      if (!Array.isArray(payload) || payload.length !== 2) {
        // message doens't match communication format; ignore
        return
      }
      var messageId = payload[0];
      var message = payload[1];

      if (typeof callback !== 'function') {
        postOutgoingMessage(e, messageId, new Error(
          'Please pass a function into register().'));
      } else {
        handleIncomingMessage(e, callback, messageId, message);
      }
    }

    self.addEventListener('message', onIncomingMessage);
  }

  var register = registerPromiseWorker;

  const Actions = {
    lolAction: LolAction,
    pageLayoutAction: PageLayoutAction,
  };

  function listener(message){
    //console.log(`REQUEST MADE: ${new Date()}`);
    //console.log(message);
    const actionClass = Actions[message.action];
    const job = new actionClass(null,message.data,{progress:true});
    const result = job.process(message.data);
    //console.log(`REQUEST COMPLETE: ${new Date()}`);
    return result;
  }

  register(listener);

}());
