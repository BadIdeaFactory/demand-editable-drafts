class Action {
  constructor(job_id, data={}, options={}){
    this.job_id  = job_id;
    this.data    = data;
    this.options = options;
    this.status  = 'waiting';

    this.callbacks = {
      start:    (this.options.start    || []),
      complete: (this.options.complete || []),
    };
  }

  async start(){
    this.status = 'started';
    if (this.callbacks.start.length > 0) {
      this.callbacks.start.forEach(cb => cb(float, message));
    }
    if (self.debug) { console.log(`Started Job (${this.constructor.name} | ${this.job_id})`); }
    const result = await this.process();
    this.complete(result);
    return result;
  }

  async process() { throw "please implement process"; }

  complete(result) {
    this.status = 'complete';
    if (self.debug) { console.log(`Completed Job (${this.constructor.name} | ${this.job_id})`); }
    this.send(result);
    if (this.callbacks.complete.length > 0){
      this.callbacks.complete.forEach(cb => cb(result));
    }
  }

  progress(float, message){ 
    if (float < 0 || float > 1) { throw `Progress (${float}) must be a float between 0 and 1.`; }
    if (this.options.progress) {
      this.send({status: this.status, progress: float, message: message});
    }
  }

  send(msgData){
    self.postMessage({
      job_id: this.job_id,
      action: this.constructor.name,
      data: msgData,
    });
  }
}

export default Action;