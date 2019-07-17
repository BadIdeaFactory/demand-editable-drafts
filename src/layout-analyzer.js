import PageLayoutAnalyzer from './pdf/page-layout-analyzer';
import PromiseWorker from 'promise-worker';

const worker = new Worker('/layout.worker.js');
const promiseWorker = new PromiseWorker(worker);

class LayoutAnalyzer {
  constructor() {
    //this.queue = new AnalysisQueue({workerPath: '/layout.worker.js'});
    this.worker = worker;
    this.promiseWorker = promiseWorker;
  }

  async analyzePage(page, width, height, scale=1.0) {
    const viewport = page.getViewport({scale: scale});
    const textItems = await page.getTextContent({normalizeWhiteSpace: true});
    const request = {
      action: 'pageLayoutAction',
      data: {
        text: textItems,
        vpTransform: viewport.transform,
        vpScale: scale,
        width: width,
        height: height,
      },
    };
    const resultData = await this.promiseWorker.postMessage(request);
    // UGHHHHHHHHHHGHGHGHHGHGGHHGHGHGHGFHJKGZHdlfkjgHFLKJGH
    // Set up a rehydration mechanism for the vanilla objects that get passed back.
    // UGHGHGHGHHGHGHGHGHFHGHGHUGUTGHTUIGHZVNBJFKHJKSDG
    const analyzer = new PageLayoutAnalyzer(null, null, null, null, null, {rehydrate:true, data:resultData});
    return analyzer;
  }
}

export default LayoutAnalyzer;

/*

pdf = app.renderer.getPDF()
page = await pdf.getPage(1)
canvas = app.renderer.getCanvas()
thing = app.startWorkerInterface()
thing.analyze(page, canvas.width, canvas.height, 1)

*/