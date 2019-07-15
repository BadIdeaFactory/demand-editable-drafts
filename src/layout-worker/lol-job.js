import Action from './action';

class LolJob extends Action {
  async process() {
    this.progress(0, `Started Job (${this.constructor.name} | ${this.job_id})`);
    const items = [1,2,3,4];
    const sleep = m => new Promise(r => setTimeout(r, m));
    const startTime = new Date();
    for (const [index, item] of items.entries()) {
      await sleep(500);
      this.progress((index+1)/items.length);
    }
    const completeTime = new Date();
    this.progress(1, `Completed Job (${this.constructor.name} | ${this.job_id})`);

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

export default LolJob;