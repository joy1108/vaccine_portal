const { scheduler } = require('./scheduler');
const interval = 1000 * 10 * 1;
console.log(`Scheduler will run every ${interval} ms`);
setInterval(() => {
  console.log('RUNNING SCHEDULER');
  scheduler();
}, interval);