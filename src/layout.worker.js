self.onmessage = function(msg){
  switch (msg.data.aTopic) {
    case 'do_sendWorkerArrBuff':
      sendWorkerArrBuff(msg.data.aBuf);
      break;
    default:
      throw 'no aTopic on incoming message to ChromeWorker';
  }
};

function sendWorkerArrBuff(aBuf) {
  console.info('from worker, PRE send back aBuf.byteLength:', aBuf.byteLength);    

  self.postMessage({aTopic:'do_sendMainArrBuff', aBuf:aBuf}, [aBuf]);

  console.info('from worker, POST send back aBuf.byteLength:', aBuf.byteLength);
}

self.onmessageerror = function(...args){
  console.error(args);
};