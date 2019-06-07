class Region {
  constructor(params, items=[]) {
    let keys = Object.keys(params);
    if (['cssStyles', 'element'].every( key => keys.includes(key) )) {
      this.top    = params.element.offsetTop;
      this.bottom = params.element.offsetTop + params.element.offsetHeight;
      this.left   = params.element.offsetLeft;
      this.right  = params.element.offsetLeft + params.element.offsetWidth*(params.cssStyles.scale||1);
    } else if (['top', 'bottom', 'left', 'right'].every( key => keys.includes(key) )) {
      this.top    = params.top;
      this.bottom = params.bottom;
      this.left   = params.left;
      this.right  = params.right;
    } else {
      // lol error
      throw "Invalid parameters (params must be an object w/ top,bottom,left,right or have an html `element`)";
    }

    this.setItems(items);
    this.center = this.findCenter();
    this.width = this.right - this.left;
    this.height = this.bottom - this.top;
    this.aspectRatio = this.width / this.height;
    this.area = this.width*this.height;

    //if (this.width < 0 || this.height < 0) { debugger; }
  }

  setItems(candidates) {
    this.items = candidates.filter((el) => this.intersects(el));
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
}

export default Region;