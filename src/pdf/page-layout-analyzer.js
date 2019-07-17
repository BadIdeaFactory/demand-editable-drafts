import Region from '../region';
import MaximalRectangles from './whitespace/maximal-rectangles';
import TextItem from './text-item';

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
      initialize(text, viewportTransform, viewportScale, width, height, options);
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
  orderByLeft(a,b){ return a.cssStyles.left - b.cssStyles.left; }

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
      const sameLine = (a, b) => a.intersects(b, {onlyVertically: true});
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
      el.setAttribute('style', 
      `left: ${space.left}px; top: ${space.top}px; width: ${space.width}px; height: ${space.height}px;`);
      spaceContainer.appendChild(el);
      space.element = el;
    });
    textLayer.appendChild(spaceContainer);
  }
}

export default PageLayoutAnalyzer;
