import docx from 'docx';
import Utils from './utils';

// Assume that Paragraphs start with an indentation.
// So the first line added to the paragraph should have some left margin.
// The next line should have a left margin that is one fewer indent.
//
// All in all the bill parser will need to look at the current line,
// the previous line, and the next line in order to determine whether or not
// this paragraph is part of a new paragraph or not.
// This lookahead may span pages as well.
//
// A new Paragraph is a change in one of:
//    - A change in indenation
//    - A change in style
//
// The definition of what indentation matches a paragraph depends on the section and style.
class BillParagraph {
  constructor() {
    this.setStyle();
    this.lines  = [];
    this.text   = [];
  }

  setStyle(style){
    const newStyles = {};
    const styleKeys = ['fontSize', 'fontName', 'margin', 'lineSpacingBefore'];
    if (style) { styleKeys.forEach(key => newStyles[key] = style[key]); }
    this.styles = newStyles;
    return this.styles;
  }

  getStyles() {
    return this.styles;
  }

  stylesMatch(line) {
    if (this.lines.length > 0) {
      const styleMatcher = (a,b) => (Utils.closeEnough(a.fontSize, b.fontSize) && a.fontName == b.fontName);
      return styleMatcher(this.styles, line.getStyles());
    } else {
      return true;
    }
  }

  appendLine(line, options={}) {
    if (this.stylesMatch(line)){
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
    if (this.styles.margin && this.styles.margin > 0) {
      let twips = Utils.pixelsToTwips(this.styles.margin);
      graf = graf.indent({firstLine: twips,});
    }
    
    const spacingBefore = (this.styles.lineSpacingBefore) ? this.styles.lineSpacingBefore : 240;
    graf = graf.spacing({before: spacingBefore});
    doc.addParagraph(graf);
  }
}

export default BillParagraph;