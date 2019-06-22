import docx from 'docx';
import Utils from './utils';
import Region from '../region';

class BillLine {
  constructor(region, options = {}){
    this.region  = region;
    this.options = options;
    this.items   = region.items;
    this.styles  = {
      margin: options.margin,
      fonts:  options.fonts,
    };
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
    let runStyles = runs.filter(r=>!r.styles.smallCaps)[0].styles;
    Object.keys(runStyles).forEach(key => this.styles[key] = runStyles[key]);
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

  stylesMatch(region) {
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

  getTextRuns() {
    const createTextRun = (runItem) => {
      let run = new docx.TextRun(this.munge(runItem.text));

      if (runItem.styles.smallCaps) { run = run.smallCaps(); }

      if (this.styles.fonts) {
        const fontData = this.styles.fonts[runItem.styles.fontName].data;
        const realFontName = fontData.name;
        if (realFontName.match(/italic/i)) { run = run.italics(); }
        if (realFontName.match(/bold/i)) { run = run.bold(); }
      }

      // fontSize is measured in pixels w/ a a 72dpi assumption
      const fontPoints = Utils.pixelsToPoints(this.styles.fontSize);
      run = run.size(fontPoints*2).font('Times');
      return run;
    };

    return this.runs.map(createTextRun);
  }
}

export default BillLine;