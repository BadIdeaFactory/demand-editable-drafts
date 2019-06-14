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

  async calculateLayout(options={}) {
    if (options.force || this._pages.length == 0) {
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
    }
    return this._pages;
  }

  derp() {
    const isBillTextParent = (region) => {
      if (region.obstacles.length > 0) {
        // bill text is always numbered.
        // The numbers will be in the left region.
        let left  = region.regions.left; // has no obstacles, only has text regions that are numbers
        let right = region.regions.right; // has text.

        let noObstaclesOnLeft    = left.obstacles.length == 0;
        let leftTextIsNumberList = left.items.every(i => i.getText().match(/^\d+$/)); // should this consider position
        let rightHasText         = right.items.length > 0;
        return noObstaclesOnLeft && leftTextIsNumberList && rightHasText;
      } else { 
        return false; 
      }
    };
    const calculateBillTextMargins = (region) => {
      const lineNumberRegion      = region.regions.left;
      const billTextRegion        = region.regions.right;
      const rightEdgeOfLeftMargin = lineNumberRegion.right;
      const billTextLeftEdge      = billTextRegion.left;
      return billTextLeftEdge - rightEdgeOfLeftMargin;
    };

    const walk = (region, path=[]) => {
      const childRegions = region.regions;
      const orderedKeys = ['top', 'left', 'right', 'bottom'];
      if (isBillTextParent(region)) {
        walk(childRegions.top, [...path, 'top']);
        state.currentPage.main.path = path;
        state.currentPage.main.regions.push(region);
        state.currentPage.main.margin = calculateBillTextMargins(region);
        state.currentPage.main.text.push(childRegions.right.getText());
        state.mainMargins.push(state.currentPage.mainMargin);
        //walk(childRegions.bottom, [...path, 'bottom']);
      } else if (Object.entries(childRegions).length > 0) {
        orderedKeys.map(key =>{ walk(childRegions[key], [...path, key]); });
      } else {
        if (state.currentPage.billTextParentPath) {
          state.currentPage.after.text.push(region.getText());
          state.currentPage.after.regions.push(region);
        } else {
          state.currentPage.before.text.push(region.getText());
          state.currentPage.before.regions.push(region);
        }
      }
    };

    let state = { mainMargins:[], pages: [] };
    this._pages.forEach(page =>{
      let currentPage = {
        before: {regions:[], text:[]},
        main:   {regions:[], text:[]},
        after:  {regions:[], text:[]},
      };
      state.currentPage = currentPage;
      walk(page.region);
      state.pages.push(currentPage);
    });
    delete state.currentPage;
    return state;
  }

  getBillText(options={}) {
    //return this._pages.reduce((texts,p)=>{
    //  texts.push(p.getText(options)); 
    //  return texts;
    //}, []).join("\n----------------\n");
    let processed = this.derp();
    let haveSeenAMain;
    return processed.pages.map(page => {
      let result;
      if (haveSeenAMain) {
        result = [page.main.text].flat();
      } else if (page.before.regions.length > 0 && page.main.regions.length > 0) {
        result = [page.before.text, page.main.text].flat();
        haveSeenAMain = true;
      } else {
        result = [page.before.text].flat();
      }
      return result.join("\n");
    }).join("\n-----------------\n");
  }
  
  // notes about docx format.
  //   - all measurements in OpenOfficeXML is in TWIPs (twentieth of a point)
  dumpDocX() {
    let doc = new docx.Document(undefined,{
      lineNumberCountBy: 1,
      lineNumberRestart: docx.LineNumberRestartFormat.NEW_PAGE,
    });
    this._pages.reduce((doc, page, index) => {
      let opts = {};
      if (index == this._pages.length-1) { opts.noPageBreak = true; }
      page.appendToDocX(doc, opts);
      return doc;
    }, doc);
    return doc;
  }
}

class BillPage {
  constructor(region){
    this.region = region;
  }

  // this is an example of doing the most basic dump
  // of all of the regions as regions.
  linearizeRegions() {
    let regions = [];
    let linearize = (region) => {
      if (Object.values(region.regions) == 0) {
        return region;
      } else {
        return Object.values(region.regions).map(r => linearize(r));
      }
    };
    return linearize(this.region);
  }

  // this should really just be a tree walk with decorators
  // which specify how to process the region in question.
  /* _getBillTextParent() {
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

    let searchRegionsForBillText = (region, path=[]) => {
      if (hasBillText(region)) {
        region.path = path;
        return region;
      } else if (Object.values(region.regions).length > 0) {
        let regions = Object.entries(region.regions);
        let entry = regions.find(([key, r]) => searchRegionsForBillText(r, [...path, key]));
        return entry[1];
      } else {
        return false;
      }
    };

    let regionWithBillText = searchRegionsForBillText(this.region);
    return regionWithBillText;
  }

  _getText(options={}){
    let text;
    if (options.fullText) {
      text = this.region.getText();
    } else {
      let billTextParent = this.getBillTextParent();
      if (billTextParent) {
        const collectText = (region, path=[]) => {
          let regionTexts = [];
          if (path.length > 0) {
            // if there are still path elements, we still have to traverse
            // the rest of the regions that precede the billTextParent.

            // so get the next region key.
            const searchKey = path.shift();
            // this is the list of all of the region keys.
            const readingOrder = ['top', 'left', 'right', 'bottom'];
            // just slice off the regions which precede the billTextParent
            // NOTE THIS POTENTIALLY IGNORES A BUNCH OF REGIONS.
            const stoppingPoint = readingOrder.indexOf(searchKey);
            const precedingKeys = readingOrder.splice(0, stoppingPoint);
            // get all the text from the preceding regions.
            precedingKeys.forEach(key => regionTexts.push(region.regions[key].getText()));
            // continue collecting text preceding the billTextParent,
            // and then the billTextParent's text itself (which is our basecase)
            const foo = collectText(region.regions[searchKey], path);
            regionTexts.push(foo);
            // if we wanted to grab the remaining text regions
            // we'd do something like this:
            let remainingKeys = readingOrder.splice(stoppingPoint+1);
            remainingKeys.forEach(key => regionTexts.push(region.regions[key].getText()));
            // but i'm not going to test that right now.
          } else {
            // this is the billTextParent
            // so push the top region.
            regionTexts.push(region.regions.top.getText());
            regionTexts.push(region.regions.right.getText());
          }
          return regionTexts;
        };

        let path = billTextParent.path;
        //text = billTextParent.regions.right.getText();
        if (billTextParent === this.region) {
          text = this.region.regions.right.getText();
        } else {
          text = collectText(this.region, path);
        }
      } else {
        text =  this.region.getText();
      }
    }
    return [text].flat().join("\n");
  } */

  appendToDocX(doc, options={}){
    let billTextParent = this.getBillTextParent();
    let billTextRegion = billTextParent.regions.right;
    let lineNumbers    = billTextParent.regions.left;
    let marginLeft     = lineNumbers.right;
    
    let graf = new docx.Paragraph(this.getText());
    graf.spacing({
      line: 240*2, // line spacing is done in 1/240ths of a line.
    });
    if (!options.noPageBreak){ graf.pageBreak(); }
    doc.addParagraph(graf);
  }
}

export default BillDocument;