import LolAction from './lol-action';
import PageLayoutAction from './page-layout-action';

self.status = "available";
self.currentJob = null;
self.debug = true;
self.actions = {
  lolAction: LolAction,
  pageLayoutAction: PageLayoutAction,
};

// `listen` is the main entry point.  It provides the main guard for the availability
// of the worker.  If the worker is available, it locks the worker and begins work.
// If messages come in while the worker is busy, it will report status, but otherwise
// will reject work by announcing that it's busy.
function listen(message){
  console.log("Recieved message from Main: ", message);

  const messageData = message.data;
  const { job_id, action, data, options } = messageData;

  if (action == "getStatus") {
    sendStatus();
  } else if (self.status == "available") {
    const actionClass = findAction(action);
    if (actionClass){
      const job = new actionClass(job_id, data, options);
      self.currentJob = job;
      job.start();
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

function sendStatus() {
  let response = {
    status: self.status,
    currentJob: self.currentJob,
  };
  sendMessage(response);
}

function completeJob(response){
  sendMessage(response);
  self.currentJob = null;
  self.status = 'available';
}