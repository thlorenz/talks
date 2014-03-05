function inspect(obj, depth) {
  return require('util').inspect(obj, false, depth || 5, true);
}

exports = module.exports = function debug() {
  if (process.env.MYMODULE_DIAGNOSTICS) console.error.apply(console, arguments);
}

exports.inspect = function(obj, depth) {
  if (process.env.MYMODULE_DIAGNOSTICS) console.error(inspect(obj, depth));
}
