import PromiseWorker from 'promise-worker';

class LayoutAnalyzer {
  constructor() {
    //this.queue = new AnalysisQueue({workerPath: '/layout.worker.js'});
    this.worker = new Worker('/layout.worker.js');
    this.promiseWorker = new PromiseWorker(this.worker);
  }

  async analyze(page, width, height, scale=1.0) {
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
    return (await this.promiseWorker.postMessage(request));
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