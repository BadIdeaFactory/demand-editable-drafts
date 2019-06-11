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

  partitionByObstacles() {
    if (this.obstacles.length > 0) {
      this.regions = {};
      [Object.entries(this.partition(this.obstacles[0], ['top', 'bottom'])), 
       Object.entries(this.intersectingPartition(this.obstacles[0], ['left', 'right']))
      ].flat().map(([key,value])=> this.regions[key] = value);
    } else {
      this.regions = {};
    }
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

  intersects(region) {
    let x1 = Math.max(this.left, region.left);
    let x2 = Math.min(this.right, region.right);
    let y1 = Math.max(this.top, region.top);
    let y2 = Math.min(this.bottom, region.bottom);
    return x1 < x2 && y1 < y2;
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

  getText() {
    let byTopLeft = (a, b) => {
      // if the y coordinates are the same
      if (a.top == b.top) {
        // determine what the x position is
        return a.left - b.left;
      } else {
        // otherwise just sort these two points based on the y.
        return a.top - b.top;
      }
    };
    let text;
    if (Object.entries(this.regions).length > 0) {
      text = Object.values(this.regions).sort(byTopLeft).map( r => r.getText() ).join("\n");
    } else {
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
      text = lines.sort(byTopLeft).map(line => 
        line.items.sort((a,b)=>a.left-b.left).map(i => i.item.str).join(" ")
      ).join("\n");
    }

    return text;
  }
}

export default Region;