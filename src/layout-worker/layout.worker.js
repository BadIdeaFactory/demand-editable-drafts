import LolAction from './lol-action';
import PageLayoutAction from './page-layout-action';
import registerPromiseWorker from 'promise-worker/register';

const Actions = {
  lolAction: LolAction,
  pageLayoutAction: PageLayoutAction,
};

function listener(message){
  console.log(`REQUEST MADE: ${new Date()}`);
  console.log(message);
  const actionClass = Actions[message.action];
  const job = new actionClass(null,message.data,{progress:true});
  const result = job.process(message.data);
  console.log(`REQUEST COMPLETE: ${new Date()}`);
  return result;
}

registerPromiseWorker(listener);