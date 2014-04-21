// Generated by CoffeeScript 1.6.3
(function() {
  var cson, jsonLoader, merge, path, yaml, yamlLoader;

  path = require('path');

  cson = require('coffeeson');

  yaml = require('js-yaml');

  merge = require('./merge');

  yamlLoader = function(filepath, cb) {
    var err, obj;
    try {
      obj = yaml.safeLoad(filepath);
    } catch (_error) {
      err = _error;
      return cb(err);
    }
    return cb(null, obj);
  };

  jsonLoader = function(filepath, cb) {
    var err, obj;
    try {
      obj = require(filepath);
    } catch (_error) {
      err = _error;
      return cb(err);
    }
    return cb(null, obj);
  };

  module.exports = function(filepath, opts, cb) {
    var loader;
    if (cb == null) {
      cb = opts;
      opts = {};
    }
    switch (path.extname(filepath)) {
      case ".json":
        loader = jsonLoader;
        break;
      case ".cson":
        loader = cson;
        break;
      case ".yml":
      case ".yaml":
        loader = ymlLoader;
        break;
      default:
        return cb(new Error("Unrecognized file type"));
    }
    return loader(filepath, function(err, obj) {
      if (err) {
        return cb(err);
      }
      merge(obj, opts);
      return cb(null, obj);
    });
  };

}).call(this);