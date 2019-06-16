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

  process() {
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
    const mungeLine = (lineRegion) => {
      let capitalMatcher = /^(\p{Lu}|\d|\W)*\p{Lu}(\p{Lu}|\d|\W)*$/u;
      if (!capitalMatcher.unicode) { // if this browser doesn't support unicode regexp
        // then we'll just deal w/ english capital letters.
        capitalMatcher = /^([^a-z]|\W)*[A-Z]([^a-z]|\W)*$/; // strings w/ at least one capital 
      }

      const sortedElements = lineRegion.items.sort((a,b)=>a.left-b.left);
      const repairedElements = sortedElements.reduce((els, el, id, sorted)=>{
        if (id > 0){
          let itemText = el.item.str;
          if (itemText.match(capitalMatcher)){
            let previousEl = sorted[id-1];
            if (previousEl.height > el.height) {
              // if the previous element is larger than this one then
              // this is probably all caps.
              els.push(el.item.str);
            } else {
              els.push(" ", el.item.str);
            }
          } else {
            els.push(" ", el.item.str);
          }
        } else {
          // this needs to check the previous line some how
          // to see if the first element is a continuation of
          // a smallCaps run from the previous line.
          els.push(el.item.str);
        }
        return els;
      }, []);
      const lineText = sortedElements.map( r => r.item.str ).join(' ');
      const repairedText = repairedElements.join('');
      console.log(repairedText.length, lineText.length)
      if (repairedText.length < lineText.length) { 
        //console.log(repairedText);
        //console.log(lineText);
        //debugger;
      }
      //let allCaps = sortedElements.filter(r=>r.item.str.match(capitalMatcher));
      //if (allCaps.length > 0){ debugger; }
      
      let mungers = [
        (l) => l.replace(/‘‘/g, '“'),
        (l) => l.replace(/’’/g, '”'),
        (l) => l.replace(/\s+/, ' '),
        (l) => {
          if (l.match(/\bll+\b/)) { return l.replace(/l/g, '＿'); }
          return l;
        },
      ];
      let resultText = mungers.reduce((l, munger) => munger(l), repairedText);
      console.log(state.currentPage.main.margin);
      return resultText;
    };

    const walk = (region, path=[]) => {
      const childRegions = region.regions;
      const orderedKeys = ['top', 'left', 'right', 'bottom'];
      if (isBillTextParent(region)) {
        walk(childRegions.top, [...path, 'top']);
        state.currentPage.main.path = path;
        state.currentPage.main.regions.push(region);
        state.currentPage.main.margin = calculateBillTextMargins(region);
        childRegions.right.regions = {}; // disregard partitions inside of main region.
        state.currentPage.main.text.push(childRegions.right.getText({line:mungeLine}));
        state.mainMargins.push(state.currentPage.main.margin);
        //walk(childRegions.bottom, [...path, 'bottom']);
      } else if (Object.entries(childRegions).length > 0) {
        orderedKeys.map(key =>{ walk(childRegions[key], [...path, key]); });
      } else {
        if (state.currentPage.billTextParentPath) {
          state.currentPage.after.text.push(region.getText({line:mungeLine}));
          state.currentPage.after.regions.push(region);
        } else {
          state.currentPage.before.text.push(region.getText({line:mungeLine}));
          state.currentPage.before.regions.push(region);
        }
      }
    };

    let state = { mainMargins:[], pages: [] };
    this._pages.forEach(page =>{
      page.initializeSections();
      state.currentPage = page;
      walk(page.region);
      state.pages.push(page);
    });
    delete state.currentPage;

    state.smallestMargin = state.mainMargins.sort((a,b)=>a-b)[0];
    return state;
  }

  getBillText(options={}) {
    // walk the region tree and process it.
    let processed = this.process();

    // now we'll walk the processed pages results.
    // Each bill has a header (this isn't the page header), 
    // so we'll print all of the text up until we find a region
    // with main bill text.  After that point we know we're in
    // bill text mode.
    let haveSeenAMain;
    return processed.pages.map(page => {
      let result;
      if (haveSeenAMain) {
        // If we're in the main section just dump the text for the main of each page.
        result = [page.main.text].flat();
      } else if (page.before.regions.length > 0 && page.main.regions.length > 0) {
        // We're still in the header, but as soon as we encounter a Main region
        // then it's time to flip the switch.
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
    this.initializeSections();
  }

  initializeSections(){
    this.main   = {regions: [], text: []};
    this.before = {regions: [], text: []};
    this.after  = {regions: [], text: []};
    return this;
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

  mungeLine(line){
    let mungers = [
      (l) => l.replace(/‘‘/g, '“'),
      (l) => l.replace(/’’/g, '”'),
      (l) => l.replace(/\s+/, ' '),
      (l) => l.replace(/\bll+\b/g, "＿"),
    ];
    return mungers.reduce((l, munger) => munger(l), line);
  }


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