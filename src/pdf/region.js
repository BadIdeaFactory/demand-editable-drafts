import TextItem from './text-item';

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
      let overlap = lines.find(line => line.intersects(item));
      if (!overlap) {
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

export default Region;