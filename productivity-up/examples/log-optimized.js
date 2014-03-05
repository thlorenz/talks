function inspect(obj, depth) {
  return require('util').inspect(obj, false, depth || 5, true);
}
function noop() {}

exports = module.exports = process.env.MYMODULE_DIAGNOSTICS 
  ? function debug() {
      if (diagnostics) console.error.apply(console, arguments);
    }
  : noop;

exports.inspect = process.env.MYMODULE_DIAGNOSTICS 
  ? function(obj, depth) {
      if (diagnostics) console.error(inspect(obj, depth));
    }
  : noop;
