import TextLayoutAnalyzer from './text-layout-analyzer.js';
import docx from 'docx';

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
    let pages = [];
    for (let pageNumber = 1; pageNumber <= this.pageCount ; pageNumber++) {
      let page = await this.getPage(pageNumber);
      let viewport = page.getViewport({scale:1});
      let canvas = document.createElement('canvas');
      canvas.height = viewport.height;
      canvas.width  = viewport.width;
      let context = canvas.getContext('2d');

      let textItems = await page.getTextContent({normalizeWhiteSpace: true});
      let analyzer = new TextLayoutAnalyzer(textItems, viewport, context);
      pages.push(analyzer.calculateLayout());
    }
    this._pages = pages.map(page=>new BillPage(page));
    return this._pages;
  }

  findBillTextStartPage() {
    let pageIndex = this._pages.findIndex(page => {
      return page.region.whiteSpaces.length > 0;
      page.region.regions;
    });
    return pageIndex + 1;
  }

  async dumpBillText() {
    let pages = await this.calculateLayout();
    return pages.reduce((texts,p)=>{
      texts.push(p.dumpText()); 
      return texts;
    }, []).join("\n----------------\n");
  }

  async dumpDocX() {
    let pages = await this.calculateLayout();
    let doc = new docx.Document();
    pages.reduce((doc, page) => {
      let billPage = new BillPage(page);
      billPage.appendToDocX(doc);
      return doc;
    }, doc);
    return doc;
  }
}

class BillPage {
  constructor(region){
    this.region = region;
  }

  findBillText() {
    let hasBillText = (region) => {
      if (region.obstacles.length > 0) {
        // bill text is always numbered.
        // The numbers will be in the left region.
        let left = region.regions.left; // has no obstacles, only has text regions that are numbers
        let right = region.regions.right; // has text.

        let noObstaclesOnLeft    = left.obstacles.length == 0;
        let leftTextIsNumberList = left.items.every(i => i.getText().match(/^\d+$/)); // should this consider position
        let rightHasText         = right.items.length > 0;
        return noObstaclesOnLeft && leftTextIsNumberList && rightHasText;
      } else { return false; }
    };

    let searchRegionsForBillText = (region) => {
      if (hasBillText(region)) {
        return region;
      } else if (Object.values(region.regions).length > 0) {
        return Object.values(region.regions).find(r => searchRegionsForBillText(r));
      } else {
        return false;
      }
    };

    let regionWithBillText = searchRegionsForBillText(this.region);
    return regionWithBillText;
  }

  dumpText(){
    return this.region.getText();
  }

  appendToDocX(doc){

  }
}

export default BillDocument;