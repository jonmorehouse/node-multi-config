// Generated by CoffeeScript 1.7.1
(function() {
  var get, h, load, setCamelCase, setEnv, setObject,
    __slice = [].slice;

  h = require("./helpers");

  get = (function(_this) {
    return function(key, defaultValue) {
      if (!(key in process.env)) {
        return defaultValue;
      }
      return h.normalizeValue(process.env[key]);
    };
  })(this);

  setObject = function(key) {
    return h.setObject(key, get(key), config, "_");
  };

  setCamelCase = function(key) {
    var err, objKey;
    objKey = h.camelCase(key);
    if (process.env[key] != null) {
      config[objKey] = get(key);
      return config[key] = get(key);
    } else {
      err = new Error("Invalid key");
      if (typeof cb !== "undefined" && cb !== null) {
        return typeof cb === "function" ? cb(err) : void 0;
      }
      throw err;
    }
  };

  setEnv = (function(_this) {
    return function(key, defaultValue) {
      return config[key] = get(key);
    };
  })(this);

  load = function() {
    var args, cb, key, keys, opts, _fn, _i, _len, _ref;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    _ref = h.splatParser.apply(h, args), keys = _ref[0], opts = _ref[1], cb = _ref[2];
    _fn = (function(_this) {
      return function(key) {
        setCamelCase(key);
        setObject(key);
        return setEnv(key);
      };
    })(this);
    for (_i = 0, _len = keys.length; _i < _len; _i++) {
      key = keys[_i];
      _fn(key);
    }
    return typeof cb === "function" ? cb() : void 0;
  };

  module.exports = {
    load: load,
    get: get
  };

}).call(this);
