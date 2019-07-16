class LayoutAnalyzer {
  constructor() {
    this.queue = new AnalysisQueue({workerPath: '/layout.worker.js'});
  }

  async analyze(page, width, height, scale=1.0) {
    const viewport = page.getViewport({scale: scale});
    const textItems = await page.getTextContent({normalizeWhiteSpace: true});
    const request = {
      job_id: 1,
      action: 'pageLayoutAction',
      data: {
        text: textItems,
        vpTransform: viewport.transform,
        vpScale: scale,
        width: width,
        height: height,
      },
    };
    this.queue.send(request);
  }
}

class AnalysisQueue {
  constructor({workerPath}) {
    this.worker = new Worker(workerPath);
    this.worker.addEventListener('message', this.listen.bind(this));

    this.queue = [];
  }

  listen(message) {
    const messageData = message.data;
    const { job_id, action, data } = messageData;
    console.log('Recieved message from worker:', job_id, action, data);
    //console.log('Recieved message from worker:', message);
    // switch?
  }

  send(message) {
    if (this.worker) {
      this.worker.postMessage(message);
    } else {
      throw "Worker is unavailable (and probably closed)";
    }
  }

  closeWorker() {
    this.worker.terminate();
    this.worker = null;
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