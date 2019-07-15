class Action {
  constructor(job_id, data, options){
    this.job_id  = job_id;
    this.data    = data;
    this.options = options;

    this.callbacks = {
      start:    (this.options.start    || []),
      complete: (this.options.complete || []),
    };
  }

  async run(){
    if (this.callbacks.start.length > 0) {
      this.callbacks.start.forEach(cb => cb(float, message));
    }
    this.progress(0, `Started Job (${this.constructor.name} | ${this.job_id})`);
    const result = await this.process();
    this.complete(result);
  }

  async process() { throw "please implement process"; }

  complete(result) {
    if (this.callbacks.complete.length > 0){
      this.callbacks.complete.forEach(cb => cb(result));
    }
  }

  progress(float, message){ 
    if (float < 0 || float > 1) { throw `Progress (${float}) must be a float between 0 and 1.`; }
    if (self.debug && false) { console.log(message); }
    this.send({progress: float, message: message});
  }

  send(msgData){
    sendMessage({
      job_id: this.job_id,
      action: this.constructor.name,
      data: msgData,
    });
  }
}

class lolJob extends Action {
  async process() {
    const items = [1,2,3,4];
    const sleep = m => new Promise(r => setTimeout(r, m));
    const startTime = new Date();
    for (const [index, item] of items.entries()) {
      await sleep(500);
      this.progress((index+1)/items.length);
    }
    const completeTime = new Date();

    return {
      job_id: this.job_id,
      action: name,
      data: { 
        message: `Acknowledging message. \n\tStarted at: ${startTime}\n\tCompleted at: ${completeTime}`,
        startTime: startTime,
        completeTime: completeTime,
      },
    };
  }
}

self.status = "available";
self.currentJob = null;
self.debug = true;
self.actions = {
  lolJob: lolJob,
};

const callbacks = {
  complete: [completeJob]
};

// `listen` is the main entry point.  It provides the main guard for the availability
// of the worker.  If the worker is available, it locks the worker and begins work.
// If messages come in while the worker is busy, it will report status, but otherwise
// will reject work by announcing that it's busy.
function listen(message){
  console.log("Recieved message from Main: ", message);

  const messageData = message.data;
  const { job_id, action, data } = messageData;

  if (action == "getStatus") {
    sendStatus(job_id, action, data);
  } else if (self.status == "available") {
    const actionClass = findAction(action);
    if (actionClass){
      const job = new actionClass(job_id, data, callbacks);
      self.currentJob = job;
      job.run();
    } else {
      throw `Unable to find action: ${action}`;
    }
  } else {
    // busy!
    sendBusy(job_id, action, data);
  }
}
self.onmessage = listen;
self.onmessageerror = function(...args){ console.error(args); };
function sendMessage(message) { self.postMessage(message); }
function sendBusy(job_id){ 
  self.postMessage({
    job_id: job_id,
    status: 'rejected',
    data: {  reason: "busy", currentJob: currentJob.job_id, action: currentJob.constructor.name }
  });
}
function findAction(actionName){ return self.actions[actionName]; }

function sendStatus(job_id, action, data) {
  const response = {
    job_id: job_id,
    action: action,
    data: {
      status:           self.status,
      currentJob:       self.currentJob,
      availableActions: Object.keys(self.actions),
    }
  };
  sendMessage(response);
}

function completeJob(response){
  sendMessage(response);
  self.currentJob = null;
  self.status = 'available';
}