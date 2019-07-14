class LayoutAnalyzer {
  constructor() {
    this.queue = new AnalysisQueue({workerPath: '/layout.worker.js'});
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