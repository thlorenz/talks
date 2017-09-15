const util = require('util')
const asyncHooks = require('async_hooks')

function print(obj) {
  process._rawDebug(util.inspect(obj, true, 100, true))
}

function init(id, type, triggerAsyncId, resource) {
  print({ id, type, triggerAsyncId, resource })
}

const hook = asyncHooks.createHook({ init })
hook.enable()
setTimeout(() => {}, 10)
