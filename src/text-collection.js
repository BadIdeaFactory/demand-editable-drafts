
/*
  ToDos:
    - topologically sort the text elements
    - create a class for individual text elements & their fields
    - use canvas to calculate the space of a width and other things for layout analysis
    - group text into lines
    - group lines into paragraphs
    - identify table-ish things

  Notes:

    Much of the calculations for what is/isn't a line or paragraph is going to have to be
    inferred based on heuristics to start with (lol maybe a neural network later).  
    So, helpfully, it should be possible to calculate the width of a space in the various 
    different fonts on the page.  Likewise it should be possible to calculate the average 
    line height and spacing.

    Font heights and the space of a width can be calculated per `pdfjs` font style.

    Two elements can be merged if they are horizontally adjacent to each other by a space
    that is <= the width of a space

    Text elements should be hierarchically clustered.  Generally speaking we know that
    documents are grouped into lines (e.g. elements which share a `y` position w/in some
    tolerance) are on the same line (although clustering may be blocked by higher level
    organization, such as column breaks).

    Thus, clustering can operate by first scanning the document from top to bottom and
    breaking the document into lines.  From there, lines can be clustered into blocks.
    Blocks should 

*/
import docx from 'docx';
import FileSaver from 'file-saver';
import Region from './region';

class TextCollection {

  constructor(text, viewport, context) {
    this.styles = text.styles;
    this.items = text.items;
    this.viewport = viewport;
    this.context = context;

    this.groups = [];

    this.styleBuf = ['left: ', 0, 'px; top: ', 0, 'px; font-size: ', 0,
      'px; font-family: ', '', ';'];

    let colors = ["Silver", "Gray", "Black", "Red", "Maroon", "Yellow", "Olive",
      "Lime", "Green", "Aqua", "Teal", "Blue", "Navy", "Fuchsia", "Purple"];
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
    if (style.vertical) {
      angle += Math.PI / 2;
    }
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

  sort() {
    return this.items.sort(this._sorters["orderItemsByTopLeft"]);
  }

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
      let capsLine = new Region(capsLineBoundaries);
      capsLine.items = capsLineRegions.map(region => region.item);
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
    let canvasBounds = new Region({
      top: 0,
      bottom: this.context.canvas.height,
      left: 0,
      right: this.context.canvas.width,
    }, elements);

    let queue = [canvasBounds];
    let whiteSpaces = [];
    while (queue.length > 0) {
      //console.log({queue: queue.length, whiteSpaces: whiteSpaces.length});
      //if (queue.length > 1000) { break; }
      // get the next region to search
      let bounds = queue.shift();
      if (bounds.items.length < 1) { whiteSpaces.push(bounds); break; }
      // find the element that divides the region most evenly
      let pivot = bounds.findPivot();

      let regionItems = bounds.items.filter((element) => element !== pivot);
      let upperRegion = new Region({ top: bounds.top,   bottom: pivot.top,     left: bounds.left, right: bounds.right }, regionItems);
      let lowerRegion = new Region({ top: pivot.bottom, bottom: bounds.bottom, left: bounds.left, right: bounds.right }, regionItems);
      let leftRegion  = new Region({ top: bounds.top,   bottom: bounds.bottom, left: bounds.left, right: pivot.left }, regionItems); 
      let rightRegion = new Region({ top: bounds.top,   bottom: bounds.bottom, left: pivot.right, right: bounds.right }, regionItems);
      let regions = [leftRegion, rightRegion, upperRegion, lowerRegion].filter( 
        // some pivots have boundaries outside of the region.
        // this prevents regions where the left/right or top/bottom boundaries are inverted.
        region => region.width > 0 && region.height > 0
      );

      regions.forEach((region) => {
        // seems like there should be a better way to filter the elements
        // since it's gotta be done twice.
        let intersectsElement = elements.some( el => el !== pivot && region.intersects(el));
        //this.context.clearRect(0,0,this.context.canvas.width, this.context.canvas.height);
        //region.drawOnto(this.context, {color: 'green'});
        //console.log(intersects);
        //intersects.forEach( el => el.drawOnto(this.context) );
        //debugger;
        if (intersectsElement){
          queue.push(region);
        } else {

          // we should memoize these results somewhere.
          let adjacentToCanvasBorders = (canvasBorders, region) => {
            let maximalLeft = new Region({
                top: region.top, 
                bottom: region.bottom, 
                left: 0, 
                right: region.right
              }, canvasBorders.items);
            let maximalRight = new Region({
                top: region.top, 
                bottom: region.bottom, 
                left: region.left, 
                right: canvasBorders.right
              }, canvasBorders.items);
            
            return (maximalLeft.items.length == 0 || maximalRight.items.length == 0);
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

          let isMeaningfulWhiteSpace = !( adjacentToCanvasBorders(canvasBounds, region) ||
                                          region.aspectRatio > 1 ||
                                          //whiteSpaces.find(space => space.equalBounds(region)) ||
                                          region.width < weightedAverageSpaceWidth );
          if ( isMeaningfulWhiteSpace ){

            let extendableElement = whiteSpaces.find( space => {
              // an element is extendable if it shares two parallel boundaries 
              // and intersects with the region.
              return (
                ( space.top == region.top && space.bottom == region.bottom ||
                  space.left == region.left && space.right == region.right  
                ) && 
                space.intersects(region)
              );
            });
            
            if (extendableElement){
              let extendedSpace = new Region({
                top: Math.min(extendableElement.top, region.top),
                bottom: Math.max(extendableElement.bottom, region.bottom),
                left: Math.min(extendableElement.left, region.left),
                right: Math.max(extendableElement.right, region.right)
              });
              whiteSpaces.splice(whiteSpaces.indexOf(extendableElement), 1, extendedSpace);
            } else {

              // these criteria need to be refactored into a single method that handles
              // quality and merging.
              let overlapsTooMuch = whiteSpaces.some(space => {
                let overlap = space.overlap(region);
                if (overlap){
                  return [overlap.area / region.area, overlap.area / space.area].some(ratio => ratio > 0.90);
                }
              });
              
              if (!overlapsTooMuch) { whiteSpaces.push(region); }
            }
            //elements.push(region);
            whiteSpaces = whiteSpaces.sort((a,b)=>b.height-a.height);
          } else {
            //console.log("horizontal", region.aspectRatio);
          }
        }
      });
      //debugger;
      //this.context.clearRect(0,0,this.context.canvas.width, this.context.canvas.height);
      //pivot.drawOnto(this.context);
      //upperRegion.drawOnto(this.context, {color: 'purple'});
      //lowerRegion.drawOnto(this.context, {color: 'green'});
      //leftRegion.drawOnto(this.context, {color: 'orange'});
      //rightRegion.drawOnto(this.context, {color: 'red'});
      //console.log("Pivot", pivot);
      //console.log("upperRegion Elements:", upperRegion.items);
      //console.log("lowerRegion Elements:", lowerRegion.items);
      //console.log("leftRegion Elements:", leftRegion.items);
      //console.log("rightRegion items:", rightRegion.items);
    }
    //whiteSpaces.forEach( space => space.drawOnto(this.context, {color: 'green'}));
    //debugger;
    this.whiteSpaces = whiteSpaces;
    return whiteSpaces;
  }

  // okay we know these documents are legislation.
  // they have a header on the first N pages.
  // Once the header is identified, the remainder of the document is
  // a numbered list of lines, and indentations.

  groupTextIntoLines() {
    // if multiple elements overlap in the Y direction
    // we should calculate whether all of the chunks belong together.
    //
    // what's an overlap in the Y direction?
    // numbers: a.top, a.fontHeight, b.top, b.fontHeight

    /* 
      A contains B
      a.top < b.top AND a.bottom > b.bottom

      B contains A
      a.top > b.top AND a.bottom < b.bottom

      A overlaps but is higher than B
      a.top < b.top AND a.bottom < b.bottom

      A overlaps but is lower than B
      a.top > b.top AND a.bottom > b.bottom
      ---------------------------------------

      So we can detect things that are NOT overlaps.
      Since we know that the top & bottom for each element
      are strictly ordered, we can just find the circumstances
      where the bottom of one element is higher than the other
      and visa versa.

      A is higher than and does not overlap B
      a.bottom < b.top

      A is lower than and does not overlap B
      a.top > b.bottom
    */

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

        let elementsOverlap = (a, b) => {
          return !(a.bottom < b.top || a.top > b.bottom);
        };

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

  dumpText() {
    return this.groupTextIntoLines().map((group) => {
      let insertSpaces = (items, item, index) => {
        items.push(item.str);
        let nextItem = group.items[index + 1];

        let spaceNeededBetween = (first, second) => {

          let firstFont = this.styles[first.fontName];
          let secondFont = this.styles[second.fontName];
          let widthOfSpace = Math.min(firstFont.spaceWidth, secondFont.spaceWidth);

          let firstRight = first.element.offsetWidth + first.element.offsetLeft;
          //console.log(firstRight, first.cssStyles.width + first.cssStyles.left);
          // (b.left - a.right) > widthOfSpace
          if ((second.element.offsetLeft - firstRight) >= (widthOfSpace)) { 
            //debugger;
            //console.log(first.element, second.element);
            //console.log(second.element.offsetLeft - firstRight, widthOfSpace);
          }

          return (second.element.offsetLeft - firstRight) >= (widthOfSpace);
        };

        if (nextItem && spaceNeededBetween(item, nextItem)) {
          items.push(" ");
        }
        return items;
      };
      let textItems = group.items.reduce(insertSpaces, []);

      let line = this.mungeLine(textItems.join(''));
      return line;
    }).join('\n');
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

export default TextCollection;