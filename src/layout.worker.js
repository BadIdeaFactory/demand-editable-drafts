class Action {
  constructor(job_id, data, options){
    this.job_id  = job_id;
    this.data    = data;
    this.options = options;

    this.callbacks = {
      start:    (this.options.start    || []),
      progress: (this.options.progress || []),
      complete: (this.options.complete || []),
    };
  }

  async run(){
    this.process(0, `Started Job (${this.constructor.name} | ${this.job_id})`);
    this.complete(await this.process());
  }

  async process() { throw "please implement process"; }

  complete(result) {
    if (this.callbacks.complete.length > 0){
      this.callbacks.complete.forEach(cb => cb(result));
    }
  }

  progress(float, message){ 
    if (float < 0 || float > 1) { throw "Progress must be a float between 0 and 1."; }
    if (self.debug) { console.log(message); }
    if (this.callbacks.progress.length > 0) {
      this.callbacks.forEach(cb => cb(float, message));
    } else {
      if (self.debug) { console.warn("progress called without callbacks"); }
    }
  }
}

class lolJob extends Action {
  async process() {
    const sleep = m => new Promise(r => setTimeout(r, m));
    const startTime = new Date();
    await sleep(3000);
    const completeTime = new Date();

    return {
      job_id: job_id,
      action: name,
      data: { 
        message: `Acknowledging message. \n\tStarted at: ${startTime}\n\tCompleted at: ${completeTime}`,
        startTime: startTime,
        completeTime: completeTime,
      },
    };
  }
}

async function uselessJob(job_id, data){
  const name = "uselessJob";

  const sleep = m => new Promise(r => setTimeout(r, m));
  const startTime = new Date();
  await sleep(3000);
  const completeTime = new Date();
  completeJob({
    job_id: job_id,
    action: name,
    data: { 
      message: `Acknowledging message. \n\tStarted at: ${startTime}\n\tCompleted at: ${completeTime}`,
      startTime: startTime,
      completeTime: completeTime,
    },
  });
}

self.status = "available";
self.debug = true;
self.actions = {
  uselessJob: uselessJob,
  lolJob: lolJob
};
self.currentJob = null;

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
    const actionFunction = findAction(action);
    if (actionFunction){
      startJob(job_id, data, actionFunction);
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
function sendResponse(message) { self.postMessage(message); }

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
  sendResponse(response);
}

async function startJob(job_id, data, action){ 
  self.status = "busy";
  const responseData = await action(data);
  completeJob({
    job_id: job_id,
    action: action.name,
    data: responseData,
  });
}

function completeJob(response){
  sendResponse(response);
  self.status = 'available';
}