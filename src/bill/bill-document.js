import PageLayoutAnalyzer from '../pdf/page-layout-analyzer';
import docx from 'docx';
import Region from '../pdf/region';
import Utils from './utils';
import BillPage from './bill-page';
import BillParagraph from './bill-paragraph';
import BillLine from './bill-line';
import LayoutAnalyzer from '../layout-analyzer';

// This class wraps and controls a `pdfjs` document and it's canvas.
class BillDocument {
  constructor(pdf, options={}){
    this.pdf               = pdf;
    this.scale             = (options.scale || 1);
    this.pageCount         = this.pdf.numPages;
    this.currentPageNumber = 1;
    this.pages = [];
    this.commonObjs = {};
    this.analyzer = new LayoutAnalyzer();
  }

  async init() {
    await this.getPage(this.currentPageNumber);
  }

  async getPage(pageNumber) {
    if (pageNumber > 0 && pageNumber <= this.pageCount) {
      return await this.pdf.getPage(pageNumber);
    } else { throw "pageNumber must be within the range of 1 to pageCount."; }
  }

  cancel() { this.cancelToken = true; }

  async calculateLayout(options={}) {
    if (options.force || this.pages.length == 0) {
      const pages = [];
      for (let pageNumber = 1; pageNumber <= this.pageCount ; pageNumber++) {
        if (this.cancelToken) { 
          console.log('calculateLayout canceled'); 
          delete this.cancelToken;
          return false;
        }
        const page = await this.calculatePageLayout(pageNumber);
        pages.push(page);
        if (options.callback) { options.callback(pageNumber, page); }
      }
      this.pages = pages;
    }
    return this.pages;
  }

  async calculatePageLayout(pageNumber,options={}) {
    const pdfPage = await this.getPage(pageNumber);
    const viewport = pdfPage.getViewport({scale:this.scale});
    const layout = await this.analyzer.analyzePage(pdfPage, viewport.width, viewport.height);
    // commonObjs is where the fonts live.
    // page.commonObjs isn't populated unless you get the operator list.
    await pdfPage.getOperatorList();
    Object.keys(pdfPage.commonObjs._objs).forEach((key) => {
      this.commonObjs[key] = pdfPage.commonObjs._objs[key];
    });
    const page = new BillPage(layout);
    page.pageNumber = pageNumber;
    page.region.pageNumber = pageNumber;
    return page;
  }

  mungeLine(lineRegion){
    //let capitalMatcher = /^(\p{Lu}|\d|\W)*\p{Lu}(\p{Lu}|\d|\W)*$/u;
    let capitalMatcher = /^([A-Z]|\W)*[A-Z]([A-Z]|\W)*$/;
    if (!capitalMatcher.unicode) { // if this browser doesn't support unicode regexp
      // then we'll just deal w/ english capital letters.
      capitalMatcher = /^([A-Z]|\d|\W)*[A-Z]([A-Z]|\d|\W)*$/; // strings w/ at least one capital 
    }

    const sortedElements = lineRegion.items.sort((a,b)=>a.left-b.left);
    const repairedElements = sortedElements.reduce((els, el, id, sorted)=>{
      const isSmallCaps = (el, id, sorted)=>{
        let previousEl = sorted[id-1];
        return (el.text.match(capitalMatcher) && previousEl.height > el.height);
      };
      // don't push a space if this is the first element,
      // or if this element is smallcaps.
      if (id > 0 && !isSmallCaps(el, id, sorted)) { 
        els.push(" ");
      }
      els.push(el.text);
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
  }

  process(options={}) {
    console.log("Processing Regions...");
    const isBillTextParent = (region) => {
      if (Object.keys(region.regions).length > 0) {
        // bill text is always numbered.
        // The numbers will be in the left region.
        let left  = region.regions.left; // has no obstacles, only has text regions that are numbers
        let right = region.regions.right; // has text.

        if (!(left && left.obstacles)) { debugger; }
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
      Object.values(childRegions).forEach(r => r.pageNumber = state.currentPage.pageNumber);
      const orderedKeys = ['top', 'left', 'right', 'bottom'];
      if (isBillTextParent(region)) {
        // This region contains line numbers on the left, and bill text on the right.
        if (state.sections.main.length == 0) {
          walk(childRegions.top, [...path, 'top']);
        }
        state.currentPage.main.path = path;
        state.currentPage.main.regions.push(region);
        state.currentPage.main.margin = calculateBillTextMargins(region);
        childRegions.right.margin = state.currentPage.main.margin;
        state.sections.main.push(childRegions.right);
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
          const sectionKey = (state.sections.main.length > 0 ? 'main' : 'before');
          state.currentPage[sectionKey].text.push(region.getText({line:this.mungeLine}));
          state.currentPage[sectionKey].regions.push(region);
          state.sections[sectionKey].push(region);
        }
      }
    };

    let state = { mainMargins:[], pages: [], sections: { before: [], main: [], after:[] } };
    this.pages.forEach(page =>{
      console.log("Disassembling page...");
      if (options.callback) { options.callback(page.pageNumber, page); }
      if (this.cancelToken) { 
        console.log('calculateLayout canceled'); 
        delete this.cancelToken;
        return false;
      }
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

  // This method takes the flattened list of regions created
  // as part of `this.process` and maps those inputs into
  // a DocX document.
  async dumpDocX(options={}) {
    console.log("Converting to DocX");
    // notes about docx format.
    //   - all measurements in OpenOfficeXML is in TWIPs (twentieth of a point)

    // `processSection` is a reducer that will append all of the elements
    // in a section (the bill header, or the bill main) to the document.
    //
    // It needs to 
    const processSection = (section, region, id, inputLines) => {
      // set up a debugging mode.
      const doc = section.doc;
      if ( region instanceof Region ){
        let leftEdge = (region.left - (region.margin || 0));
        // margin accounts for some of the whitespace so move the left edge to the right.
        if (section.name == "header") { leftEdge += Utils.defaultMargin;}
        const lines = region.groupItems().reduce((billLines, lineRegion)=>{
          const previousLine = billLines[billLines.length-1];
          let spacingBefore = 0;
          if (previousLine) { 
            spacingBefore = lineRegion.top - previousLine.region.bottom;
            //if (spacingBefore < 0) { debugger; }
          }
          const leftMargin = lineRegion.left - leftEdge;
          const attrs = {
            margin: leftMargin, 
            fonts: this.commonObjs,
            lineSpacingBefore: Utils.pixelsToTwips(spacingBefore),
          };
          const billLine = new BillLine(lineRegion, attrs);
          billLines.push(billLine);
          return billLines;
        }, []);
        const paragraphs = lines.reduce((grafs, line) => {
          let currentGraf = grafs[grafs.length-1];
          // skip this function for now.  Every line is its own graf.
          if (currentGraf && line.stylesMatch(currentGraf) && false) {
            currentGraf.appendLine(line);
          } else {
            let newGraf = new BillParagraph();
            newGraf.appendLine(line);
            grafs.push(newGraf);
          }
          return grafs;
        }, []);

        if ( inputLines[id+1] == "<PAGEBREAK/>" ) {
          let lastGraf = paragraphs[paragraphs.length-1];
          lastGraf.pageBreak = true;
        }

        paragraphs.forEach(graf => graf.addToDoc(doc));
        if (!(doc instanceof docx.Document)) { 
          doc.paragraphs.push(...paragraphs);
        }
      }
      return section;
    };
    
    const billData = this.process({callback: options.progressCallback});
    if (!billData) { return false; } // this is the cancel mechanism.
    // walk the region tree
    const billHeader = billData.sections.before;
    const billMain = billData.sections.main;

    let margins = billMain.reduce((arr, r)=>{
      if (r instanceof Region) { arr.push(r.margin); }
      return arr;
    }, []);

    const numberingSpacing = margins.sort()[0];
    let doc =  new docx.Document(undefined, {
      lineNumberCountBy: 1,
      lineNumberRestart: docx.LineNumberRestartFormat.NEW_PAGE,
      lineNumberDistance: Utils.pixelsToTwips(numberingSpacing),
    });

    const headerLines = billHeader.reduce(processSection, 
      { name:"header", doc: doc });

    // start the main section.
    const mainLines = billMain.reduce(processSection, 
      { name:"main", doc: doc });

    const docStyles = new docx.Styles();

    const packer = new docx.Packer();
    return packer.toBuffer(doc, docStyles);
  }
}


export default BillDocument;