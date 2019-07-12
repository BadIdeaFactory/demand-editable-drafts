import PDFUtils from './pdf-utils';

/*
  `TextItem` is the connector between PDFJS+DOM and the layout calculation system.
  
*/

class TextItem {
  constructor(item, styles) {
    this.item = item;
    this.documentStyles = styles;
    this.fontStyle = this.documentStyles[this.item.fontName];

    this.fontFamily = this.fontStyle.fontFamily;
  }

  calculateDimensions(viewport, context){
    const style = this.fontStyle;
    const tx = PDFUtils.matrix_transform(viewport.transform, this.item.transform);
    
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
    const scaledItemWidth = ((style.vertical) ? this.item.height : this.item.width) * viewport.scale;
    
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
    this.angle  = angle;
    this.height = fontHeight;
    this.width  = scaledItemWidth;

    this.left   = left;
    this.top    = top;
    // hmmmmm. these should probably also factor in the angle like we're doing with the left/top.
    this.bottom = this.top  + this.height;
    this.right  = this.left + this.width;
  
    return this;
  }

  calculateStyles(viewport, context) {
    let item = this.item;
    let styles = this.styles;
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

    let tx = PDFUtils.matrix_transform(viewport.transform, item.transform);
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
    return this;
  }

}

export default TextItem;