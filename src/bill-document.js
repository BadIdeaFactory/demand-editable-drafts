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

  // This method takes the flattened list of regions created
  // as part of `this.process` and maps those inputs into
  // a DocX document.
  dumpDocX(options={}) {
  // notes about docx format.
  //   - all measurements in OpenOfficeXML is in TWIPs (twentieth of a point)

  // `processSection` is a reducer that will append all of the elements
  // in a section (the bill header, or the bill main) to the document.
  //
  // It needs to 
  const processSection = (doc, region, id, inputLines) => {
      // set up a debugging mode.
      let result = (doc instanceof docx.Document) ? doc : doc.docx;
      if ( region instanceof Region ){
        const lines = region.groupItems().map(l=> new Line(l));
        const paragraphs = lines.reduce((grafs, line) => {
          let currentGraf = grafs[grafs.length-1];
          if (currentGraf && line.styleMatches(currentGraf)) {
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
      return result;
    };
    
    const billData = this.process();
    // walk the region tree
    const billHeader = billData.sections.before;
    const billMain = billData.sections.main;

    let doc =  new docx.Document();

    const headerLines = billHeader.reduce(processSection, doc);

    const numberingSpacing = billData.mainMargins.sort()[0];
    // start the main section.
    doc.addSection({
      lineNumberCountBy: 1,
      lineNumberRestart: docx.LineNumberRestartFormat.NEW_PAGE,
      lineNumberDistance: Utils.pixelsToTWIPs(numberingSpacing),
    });
    const mainLines = billMain.reduce(processSection, doc);

    debugger;
    return doc;
  }
}

class Line {
  constructor(region, options = {}){
    this.region  = region;
    this.options = options;
    this.items   = region.items;
    this.styles  = {};
    this.runs    = [];
    this.analyze();
  }

  analyze() {
    this.runs = []; // repaired text

    let capitalMatcher = /^(\p{Lu}|\d|\W)*\p{Lu}(\p{Lu}|\d|\W)*$/u;
    if (!capitalMatcher.unicode) { // if this browser doesn't support unicode regexp
      // then we'll just deal w/ english capital letters.
      capitalMatcher = /^([^a-z]|\W)*[A-Z]([^a-z]|\W)*$/; // strings w/ at least one capital 
    }

    const getFontNames = (els) => els.map(el => el.item.fontName);
    const getHeights = (els) => els.map(el => el.height);
    const isSmallCaps = (el, id, sorted)=>{
      let mainHeight;
      let fontName;
      const elFonts = getFontNames(sorted);
      const elHeights = getHeights(sorted).filter(h=> !Utils.closeEnough(h, el.height));
      if (elFonts.every(name => elFonts[0])) { 
        fontName = elFonts[0]; 
      } else {
        console.log(sorted);
        debugger;
        throw "Assessing SmallCaps, but found multiple fonts";
      }
      if (elHeights.every(h => Utils.closeEnough(h, elHeights[0]))) { 
        mainHeight = elHeights[0];
      } else {
        console.log(sorted);
        debugger;
        throw "Assessing SmallCaps, but found multiple font sizes";
      }
      let result = (
        mainHeight > el.height &&
        el.item.fontName == fontName &&
        el.item.str.match(capitalMatcher)
      );
      //if (result) { console.log(el.item.str); }
      return result;
    };

    const gatherRuns = (runs, el, id, sorted)=>{
      // don't push a space if this is the first element,
      // or if this element is smallcaps.
      //const itemText = el.item.str;
      //if (id > 0 && !isSmallCaps(el, id, sorted)) { els.push(" "); }

      let components = [];
      // smallCaps have to be noted for styling.
      if (isSmallCaps(el, id, sorted)) {
        let previous = runs[runs.length-1]; //runs.pop();
        let danglerMatch;
        if (previous) { danglerMatch = previous.text.match(/^(.*)\b(\w+)$/u); }
        // if the previous element has a dangling capital letter for the smallCaps
        // run, we need to resegment the previous run to move the capital letter
        // into the smallCaps run.
        if (danglerMatch && !previous.styles.smallCaps) {
          let [matchText, previousText, dangler] = danglerMatch;
  
          let text = `${dangler}${el.item.str.toLocaleLowerCase()}`;
          if (sorted[id+1].item.str.match(/^\w/)) { text += ' '; }
  
          previous.text = previousText;
          let smallCapsRun = {
            regions: [...previous.regions, el],
            text:    text,
            styles:  {},
          };

          // match the styles for this run to the previous one.
          Object.keys(previous.styles).forEach(key => smallCapsRun.styles[key] = previous.styles[key]);
          // and note the smallCaps and the edit on the previous run.
          smallCapsRun.styles.smallCaps = true;
          previous.styles.removedDanglingSmallCap = true;
          // if after the edit, the previous run has no text, discard it.
          if (previous.text.length == 0) { runs.pop(); }
          // but we'll always need the smallCaps run.
          components.push(smallCapsRun);  
        } else {
          const text = `${el.item.str.toLocaleLowerCase()} `;
          const styles = this.extractStyle(el);
          styles.smallCaps = true;
          components = [{
            regions: [el],
            text:    text,
            styles:  styles,
          }];  
        }
      } else {
        components = [{
          regions: [el],
          text:    el.getText(),
          styles:  this.extractStyle(el),
        }];
      }

      runs.push(...components);
      return runs;
    };

    const sortedElements = this.items.sort((a,b)=>a.left-b.left);
    const runs = sortedElements.reduce(gatherRuns, []);

    this.runs   = runs;
    this.styles = runs.filter(r=>!r.styles.smallCaps)[0].styles;
    this.text = this.runs.map(r=>r.text).join(" ");
  }

  extractStyle(obj){
    if (obj instanceof Region && obj.item) {
      return { fontSize: obj.height, fontName: obj.item.fontName, };
    } else {
      return obj.getStyles();
    }
  }

  getStyles(){
    //return this.items.map(itemRegion=>this.extractStyle(itemRegion));
    return this.styles;
  }

  styleMatches(region) {
    const styleMatcher = (a,b) => (Utils.closeEnough(a.fontSize, b.fontSize) && a.fontName == b.fontName);
    const regionStyles = this.extractStyle(region);
    return styleMatcher(this.styles, regionStyles);
  }

  munge(text){
    let mungers = [
      (l) => l.replace(/‘‘/g, '“'),
      (l) => l.replace(/’’/g, '”'),
      (l) => l.replace(/\s+/g, ' '),
      (l) => {
        if (l.match(/\bll+\b/)) { return l.replace(/l/g, '＿'); }
        return l;
      },
    ];
    let resultText = mungers.reduce((l, munger) => munger(l), text);
    return resultText;
  }

  getText(){ return this.munge(this.text); }

  addToParagraph(graf, options={}){
    let textRuns = this.runs.map(runItem => {
      let run = new docx.TextRun(this.munge(runItem.text));
      if (runItem.styles.smallCaps) { run = run.smallCaps(); }
      return run;
    });
    if (options.withBreak) { textRuns[textRuns.length-1] = textRuns[textRuns.length-1].break(); }
    textRuns.forEach( r => graf.addRun(r) );
    return graf;
  }

  _setDocXStyles(run){
    const pixelsPerInch = (96*window.devicePixelRatio);
    // fontSize is measured in pixels w/ a a 72dpi assumption
    let fontPoints = this.styles.fontSize * (72/pixelsPerInch);
    return run.size(fontPoints*2).font('Times');
  }

  getTextRuns() {
    return this.runs.map(runItem => {
      let run = new docx.TextRun(this.munge(runItem.text));
      if (runItem.styles.smallCaps) { run = run.smallCaps(); }
      return this._setDocXStyles(run);
    });
  }
}

class BillParagraph {
  constructor() {
    this.setStyle();
    this.lines  = [];
    this.text   = [];
  }

  setStyle(style){
    const newStyles = {};
    const styleKeys = ['fontSize', 'fontName', 'leftMargin'];
    if (style) { styleKeys.forEach(key => newStyles[key] = style[key]); }
    this.styles = newStyles;
    return this.styles;
  }

  getStyles() {
    return this.styles;
  }

  styleMatches(line) {
    if (this.lines.length > 0) {
      const styleMatcher = (a,b) => (Utils.closeEnough(a.fontSize, b.fontSize) && a.fontName == b.fontName);
      return styleMatcher(this.styles, line.getStyles());
    } else {
      return true;
    }
  }

  appendLine(line, options={}) {
    if (this.styleMatches(line)){
      if (this.lines.length == 0) { this.setStyle(line.getStyles()); }
      this.text.push(line.getText());
      this.lines.push(line);
    } else {
      throw "line styles don't match this paragraph's styles.";
    }
  }

  addToDoc(doc) {
    let graf = new docx.Paragraph();
    this.lines.forEach((line, id) => {
      let runs = line.getTextRuns();
      // if this isn't the first line,
      // add a break before appending this line.
      // (the first line is separated by the paragraph break)
      if (id > 0){ runs[0] = runs[0].break(); }
      //runs[runs.length-1] = runs[runs.length-1].break();
      runs.forEach(run => graf.addRun(run));
    });
    if (this.pageBreak) { graf = graf.pageBreak(); }
    doc.addParagraph(graf.spacing({line: 240*2}));
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

const Utils = {
  pixelsToPoints: (px) => {
    const pixelsPerInch = (96*window.devicePixelRatio);
    // fontSize is measured in pixels w/ a a 72dpi assumption
    return px * (72/pixelsPerInch);
  },
  pixelsToTWIPs: (px) =>{
    return Utils.pixelsToPoints(px) * 20;
  },
  closeEnough: (a, b) => { return (Math.abs(a - b) < 0.001); },
};

export default BillDocument;