const util = require('util')
const asyncHooks = require('async_hooks')

function print(obj) {
  process._rawDebug(util.inspect(obj, true, 100, true))
}

function init(id, type, triggerAsyncId, resource) {
  print({ id, type, triggerAsyncId })
}

function before(id) {
  print({ stage: 'before', id })
}

function after(id) {
  print({ stage: 'after', id })
}

const hook = asyncHooks.createHook({ init, before, after })
hook.enable()
setTimeout(ontimeout, 10)

function ontimeout() {
  print('User callback fired')
}
