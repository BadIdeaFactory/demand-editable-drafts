import PDFUtils from './pdf-utils';
import TextItem from './text-item';

class TextItemExtractor {
  constructor(text, viewport){
    this.pdfjsText     = text;
    this.viewport      = viewport;

    this.canvas        = document.createElement('canvas');
    this.canvas.height = viewport.height;
    this.canvas.width  = viewport.width;
    this.context       = this.canvas.getContext('2d');

    this.items = [];
  }

  extractItems() {
    const styles    = this.pdfjsText.styles;
    const pdfjsItems = this.pdfjsText.items;

    this.items = pdfjsItems.map((pdfjsItem) => {
      const item = new TextItem(pdfjsItem, styles);
      item.calculateDimensions(this.viewport, this.context);
      return item;
    });

    return this.items;
  }
}

export default TextItemExtractor;