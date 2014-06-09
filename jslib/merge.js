// Generated by CoffeeScript 1.7.1
(function() {
  var extend;

  extend = require('extend');

  module.exports = function(obj, opts) {
    var deep;
    if (opts == null) {
      deep = false;
    } else if (typeof opts === 'boolean') {
      deep = opts;
    } else if (typeof opts === 'object' && (opts.deep != null)) {
      deep = opts.deep;
    } else {
      deep = false;
    }
    return extend(deep, global.config, obj);
  };

}).call(this);
