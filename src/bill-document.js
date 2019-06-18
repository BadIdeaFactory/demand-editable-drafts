import TextLayoutAnalyzer from './text-layout-analyzer.js';
import docx from 'docx';
import Region from './region.js';

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
        let viewport = page.getViewport({scale:this.scale});
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

  mungeLine(lineRegion){
    let capitalMatcher = /^(\p{Lu}|\d|\W)*\p{Lu}(\p{Lu}|\d|\W)*$/u;
    if (!capitalMatcher.unicode) { // if this browser doesn't support unicode regexp
      // then we'll just deal w/ english capital letters.
      capitalMatcher = /^([^a-z]|\W)*[A-Z]([^a-z]|\W)*$/; // strings w/ at least one capital 
    }

    const sortedElements = lineRegion.items.sort((a,b)=>a.left-b.left);
    const repairedElements = sortedElements.reduce((els, el, id, sorted)=>{
      const isSmallCaps = (el, id, sorted)=>{
        let previousEl = sorted[id-1];
        return (el.item.str.match(capitalMatcher) && previousEl.height > el.height);
      };
      // don't push a space if this is the first element,
      // or if this element is smallcaps.
      const itemText = el.item.str;
      if (id > 0 && !isSmallCaps(el, id, sorted)) { 
        els.push(" ");
      }
      els.push(itemText);
      return els;
    }, []);
    const repairedText = repairedElements.join('');
    
    let mungers = [
      (l) => l.replace(/‘‘/g, '“'),
      (l) => l.replace(/’’/g, '”'),
      (l) => l.replace(/\s+/g, ' '),
      (l) => {
        if (l.match(/\bll+\b/)) { return l.replace(/l/g, '＿'); }
        return l;
      },
    ];
    let resultText = mungers.reduce((l, munger) => munger(l), repairedText);
    return resultText;
  };

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

    const walk = (region, path=[]) => {
      const childRegions = region.regions;
      const orderedKeys = ['top', 'left', 'right', 'bottom'];
      if (isBillTextParent(region)) {
        if (state.sections.main.length == 0) {
          walk(childRegions.top, [...path, 'top']);
        }
        state.currentPage.main.path = path;
        state.currentPage.main.regions.push(region);
        state.sections.main.push(childRegions.right);
        state.currentPage.main.margin = calculateBillTextMargins(region);
        childRegions.right.regions = {}; // disregard partitions inside of main region.
        state.currentPage.main.text.push(childRegions.right.getText({line:this.mungeLine}));
        state.mainMargins.push(state.currentPage.main.margin);
        //walk(childRegions.bottom, [...path, 'bottom']);
      } else if (Object.entries(childRegions).length > 0) {
        orderedKeys.map(key =>{ 
          walk(childRegions[key], [...path, key]);
        });
      } else {
        if (state.currentPage.billTextParentPath) {
          state.currentPage.after.text.push(region.getText({line:this.mungeLine}));
          state.currentPage.after.regions.push(region);
          state.sections.after.push(region);
        } else {
          state.currentPage.before.text.push(region.getText({line:this.mungeLine}));
          state.currentPage.before.regions.push(region);
          state.sections.before.push(region);
        }
      }
    };

    let state = { mainMargins:[], pages: [], sections: { before: [], main: [], after:[] } };
    this._pages.forEach(page =>{
      page.initializeSections();
      state.currentPage = page;
      walk(page.region);
      state.pages.push(page);
      let sectionKey = (state.sections.main.length > 0 ? 'main' : 'before');
      state.sections[sectionKey].push("<PAGEBREAK/>");
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
  dumpDocX(options={}) {
    const processSection = (doc, region, id, inputLines) => {
      // set up a debugging mode.
      let result = (doc instanceof docx.Document) ? doc : doc.docx;
      if ( region instanceof Region ){
        const getLineStyles = (line) => {
          return line.items.reduce((styles, itemRegion)=>{
            styles.push({ fontSize: itemRegion.height, fontName: itemRegion.item.fontName, });
            return styles;
          }, []);
        };

        const stylesMatch = (graf, line) => {
          const closeEnough  = (a,b) => (Math.abs(a - b) < 0.001);
          const styleMatcher = (a,b) => (closeEnough(a.fontSize, b.fontSize) && a.fontName == b.fontName);
          const lineStyles = getLineStyles(line);
          return graf.styles.some(grafStyle => {
            return lineStyles.some(lineStyle => styleMatcher(grafStyle, lineStyle));
          });
        };

        const lines = region.groupItems();
        const paragraphs = [];
        lines.reduce((grafs, line, id, lines) => {
          let currentGraf = grafs[grafs.length-1];
          if (currentGraf && stylesMatch(currentGraf, line)) {
            currentGraf.lines.push(line);
            currentGraf.text.push(line.getText());
            currentGraf.styles.push(...getLineStyles(line));
            const run = new docx.TextRun(line.getText({line:this.mungeLine})).break();
            currentGraf.data = currentGraf.data.addRun(run);
          } else {
            const graf = new docx.Paragraph(line.getText({line:this.mungeLine}));
            currentGraf = { 
              lines: [line], 
              text: [line.getText()], 
              styles: getLineStyles(line),
              data: graf,
            };
            grafs.push(currentGraf);
          }
          return grafs;
        }, paragraphs);

        if ( inputLines[id+1] == "<PAGEBREAK/>" ) {
          let lastGraf = paragraphs[paragraphs.length-1];
          lastGraf.data = lastGraf.data.pageBreak();
        }

        paragraphs.map(graf => graf.data).flat().forEach(d => result.addParagraph(d));
        if (!(doc instanceof docx.Document)) { 
          doc.paragraphs.push(paragraphs);
          doc.docx = result;
        }
      }
      return result;
    };
    
    const billData = this.process();
    // walk the region tree
    const billHeader = billData.sections.before;
    const billMain = billData.sections.main;

    let doc =  new docx.Document();

    doc.addSection({
      
    });
    const headerLines = billHeader.reduce(processSection, doc);

    // start the main section.
    doc.addSection({
      lineNumberCountBy: 1,
      lineNumberRestart: docx.LineNumberRestartFormat.NEW_PAGE,
      lineNumberDistance: 240,
    });
    const mainLines = billMain.reduce(processSection, doc);

    debugger;
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
}

export default BillDocument;