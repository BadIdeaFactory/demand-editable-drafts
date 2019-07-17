import PDFUtils from './pdf-utils';

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

    if (angle !== 0) { this.radians =  angle * (180 / Math.PI); }
    const scaledItemWidth = ((style.vertical) ? this.data.height : this.data.width) * vpScale;
    
    let left, top, bottom, right; 
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
      transform = `rotate(${this.angle}deg) ${transform}`;
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

export default TextItem;