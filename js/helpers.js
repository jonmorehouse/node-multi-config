// Generated by CoffeeScript 1.7.1
var argParser, camelCase, normalizeCase, normalizeValue, setObject, splatParser,
  __slice = [].slice;

camelCase = function(key) {
  var normalize, piece, pieces;
  normalize = function(input) {
    return input[0].toUpperCase() + input.slice(1, input.length).toLowerCase();
  };
  pieces = key.split("_");
  if (pieces.length > 1) {
    return pieces[0].toLowerCase() + ((function() {
      var _i, _len, _ref, _results;
      _ref = pieces.slice(1, +pieces.length + 1 || 9e9);
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        piece = _ref[_i];
        _results.push(normalize(piece));
      }
      return _results;
    })()).join("");
  } else {
    return pieces[0].toLowerCase();
  }
};

normalizeValue = function(value) {
  var array, number;
  number = value.match(/^([0-9]+)$/);
  if (number != null) {
    return parseInt(value);
  }
  array = value.split(",");
  if ((array != null) && array.length > 1) {
    return (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = array.length; _i < _len; _i++) {
        value = array[_i];
        _results.push(normalizeValue(value));
      }
      return _results;
    })();
  }
  return value;
};

splatParser = function() {
  var arg, args, cb, elements, index, opts, _i, _len;
  args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
  args = args.reverse();
  elements = [];
  opts = null;
  cb = null;
  for (index = _i = 0, _len = args.length; _i < _len; index = ++_i) {
    arg = args[index];
    if (arg instanceof Function && index === 0) {
      cb = arg;
    } else if (arg instanceof Array) {
      Array.prototype.push.apply(elements, arg.reverse());
    } else if (arg instanceof Object && (index === 0 || index === 1)) {
      opts = arg;
    } else {
      elements.push(arg);
    }
  }
  return [elements.reverse(), opts, cb];
};

argParser = function() {
  var args;
  args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
  switch (args.length) {
    case 0:
      return [null, null];
    case 1:
      if (typeof args[0] === "object") {
        return [args[0], null];
      }
      return [null, args[0]];
    case 2:
      if (typeof args[0] === "object") {
        return [args[0], args[1]];
      }
      return [args[1], args[0]];
    default:
      return [args[0], args[1]];
  }
};

normalizeCase = function(key) {
  if (key.toUpperCase() === key) {
    return camelCase(key);
  }
  return key;
};

setObject = (function(_this) {
  return function(key, value, obj, delimiter) {
    var piece, pieces, _recurser;
    if (obj == null) {
      obj = config;
    }
    if (delimiter == null) {
      delimiter = /[,_\/]+/;
    }
    pieces = (function() {
      var _i, _len, _ref, _results;
      _ref = key.split(delimiter);
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        piece = _ref[_i];
        if (piece.length > 0) {
          _results.push(normalizeCase(piece));
        }
      }
      return _results;
    })();
    (_recurser = function(keys, pObj, value) {
      if (keys.length === 0) {

      } else if (keys.length === 1) {
        return pObj[keys[0]] = value;
      } else {
        if ((pObj[keys[0]] == null) || !typeof pObj[keys[0]] === "object") {
          pObj[keys[0]] = {};
        }
        return _recurser(keys.slice(1), pObj[keys[0]], value);
      }
    })(pieces, obj, value);
    return obj;
  };
})(this);

module.exports = {
  setObject: setObject,
  camelCase: camelCase,
  normalizeValue: normalizeValue,
  normalizeCase: normalizeCase,
  argParser: argParser,
  splatParser: splatParser
};
