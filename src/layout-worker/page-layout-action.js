import Action from "./action";
import TextLayoutAnalyzer from "../pdf/text-layout-analyzer";

class PageLayoutAction extends Action {
  async process({text, vpTransform, vpScale, width, height}){
    const analyzer = new TextLayoutAnalyzer(text, vpTransform, vpScale, width, height);
    this.progress(0, `Calculating Item Styles`);
    analyzer._calculateStyles();
    this.progress(0.33, `Calculating White Space`);
    analyzer._calculateWhiteSpace();
    this.progress(0.66, `Segmenting Regions`);
    analyzer.groupRegions();
    analyzer.calculatedLayout = true;
    this.progress(1, `Done`);
    return analyzer;
  }
}

export default PageLayoutAction;