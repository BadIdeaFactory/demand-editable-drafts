class WorkerInterface {
  constructor() {
    this.worker = new Worker('/layout.worker.js');
    this.worker.addEventListener('message', this.handleMessageFromWorker.bind(this));
  }

  handleMessageFromWorker(msg) {
    console.log('incoming message from worker, msg:', msg);
    switch (msg.data.aTopic) {
      case 'do_sendMainArrBuff':
        this.sendMainArrBuff(msg.data.aBuf);
        break;
      default:
        throw 'no aTopic on incoming message to ChromeWorker';
    }
  }

  sendBuffer() {
    // Ok lets create the buffer and send it
    var arrBuf = new ArrayBuffer(8);
    console.info('arrBuf.byteLength pre transfer:', arrBuf.byteLength);

    this.worker.postMessage(
        {
            aTopic: 'do_sendWorkerArrBuff',
            aBuf: arrBuf // The array buffer that we passed to the transferrable section 3 lines below
        },
        [
            arrBuf // The array buffer we created 9 lines above
        ]
    );
    console.info('arrBuf.byteLength post transfer:', arrBuf.byteLength);
  }

  sendMainArrBuff(buf) {
    console.info("main recieved buffer", buf);
  }

  closeWorker() {
    this.worker.terminate();
    this.worker = null;
  }
}

export default WorkerInterface;