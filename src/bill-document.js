import TextLayoutAnalyzer from './text-layout-analyzer.js';

// This class wraps and controls a `pdfjs` document and it's canvas.
class BillDocument {
  constructor(pdf, options={}){
    this.pdf               = pdf;
    this.scale             = (options.scale || 1);
    this.pageCount         = this.pdf.numPages;
    this.currentPageNumber = 1;
    this._pages = [];
  }

  async init() {
    await this.getPage(this.currentPageNumber);
  }

  async getPage(pageNumber) {
    if (pageNumber > 0 && pageNumber <= this.pageCount) {
      return await this.pdf.getPage(pageNumber);
    } else { throw "pageNumber must be within the range of 1 to pageCount."; }
  }

  async calculateLayout() {
    for (let pageNumber = 1; pageNumber <= this.pageCount ; pageNumber++) {
      let page = await this.getPage(pageNumber);
      let viewport = page.getViewport({scale:1});
      let canvas = document.createElement('canvas');
      canvas.height = viewport.height;
      canvas.width  = viewport.width;
      let context = canvas.getContext('2d');

      let textItems = await page.getTextContent({normalizeWhiteSpace: true});
      let analyzer = new TextLayoutAnalyzer(textItems, viewport, context);
      this._pages.push(analyzer.calculateLayout());
    }
    return this._pages;
  }

  async dumpBillText() {
    let pages = await this.calculateLayout();
    return pages.reduce((texts,p)=>{
      texts.push(p.getText()); 
      return texts;
    }, []).join("\n----------------\n");
  }
}

class BillPage {
  constructor(region){
    this.region = region;
  }

  findBillText() {
    // bill text is always numbered.
    // The numbers will be in the left region.
    if (Object.entries(this.region.regions).length > 0) {

    }
  }

  dumpText(){
    return this.region.dumpText();
  }
}

export default BillDocument;