// Generated by CoffeeScript 1.7.1
var async, csonLoader, fs, h, jsonLoader, load, merge, path, yamlLoader,
  __slice = [].slice;

path = require('path');

merge = require("./merge");

h = require("./helpers");

fs = require('fs');

async = require('async');

yamlLoader = function(filepath, cb) {
  var yaml;
  yaml = require('js-yaml');
  return fs.readFile(filepath, "utf-8", function(err, str) {
    var obj;
    if (err != null) {
      if (typeof cb === "function") {
        cb(err);
      }
    }
    try {
      obj = yaml.safeLoad(str);
    } catch (_error) {
      err = _error;
      return cb(err);
    }
    return cb(null, obj);
  });
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

csonLoader = function(filepath, cb) {
  var cson;
  cson = require('coffeeson');
  return cson(filepath, cb);
};

load = function() {
  var args, cb, filepaths, opts, _, _ref;
  args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
  _ref = h.splatParser.apply(h, args), filepaths = _ref[0], opts = _ref[1], cb = _ref[2];
  _ = function(filepath, cb) {
    var loader;
    switch (path.extname(filepath)) {
      case ".json":
        loader = jsonLoader;
        break;
      case ".cson":
        loader = csonLoader;
        break;
      case ".yml":
      case ".yaml":
        loader = yamlLoader;
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
  return async.each(filepaths, _, function(err) {
    return typeof cb === "function" ? cb() : void 0;
  });
};

module.exports = {
  load: load
};
