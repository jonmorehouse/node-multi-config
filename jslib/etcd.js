// Generated by CoffeeScript 1.6.3
(function() {
  var Etcd, async, close, env, etcd, getClient, h, loadKeys, setFromKey, setFromResponse, setWatcher, stopWatcher, watchers,
    __slice = [].slice;

  Etcd = require('node-etcd');

  require("./index");

  env = require("./env");

  async = require('async');

  h = require("./helpers");

  etcd = null;

  watchers = {};

  getClient = function() {
    if (etcd != null) {
      return etcd;
    }
    if (config.etcdHost == null) {
      config.etcdHost = env.getEnv("ETCD_HOST", "localhost");
    }
    if (config.etcdPort == null) {
      config.etcdPort = env.getEnv("ETCD_PORT", 4001);
    }
    if (config.etcdNamespace == null) {
      config.etcdNamespace = env.getEnv("ETCD_NAMESPACE", "");
    }
    return etcd = new Etcd(config.etcdHost, config.etcdPort);
  };

  setFromResponse = function(res) {
    var key;
    key = res.node.key.replace("/", "");
    if ((res.node.dir == null) || !res.node.dir) {
      config[key] = res.node.value;
      return;
    }
    return p(res.node.nodes);
  };

  setFromKey = function() {
    var args, cb, key, opts, _ref;
    key = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    _ref = h.argParser.apply(h, __slice.call(args).concat([{
      recursive: true
    }])), opts = _ref[0], cb = _ref[1];
    return etcd.get(key, function(err, res) {
      if (err) {
        return typeof cb === "function" ? cb(err) : void 0;
      }
      setFromResponse(res);
      return typeof cb === "function" ? cb() : void 0;
    });
  };

  setWatcher = function(key, cb) {
    var _etc;
    if (key in watchers) {
      return typeof cb === "function" ? cb() : void 0;
    }
    _etc = new Etcd(config.etcdHost, config.etcdPort);
    watchers[key] = _etc.watcher(key);
    watchers[key].on("set", function(res) {
      return setFromResponse(res);
    });
    watchers[key].on("error", function(res) {});
    return typeof cb === "function" ? cb() : void 0;
  };

  stopWatcher = function(key, cb) {
    var _this = this;
    if (!(key in watchers)) {
      return typeof cb === "function" ? cb() : void 0;
    }
    watchers[key].on("stop", function(err) {
      delete watchers[key];
      return typeof cb === "function" ? cb() : void 0;
    });
    return watchers[key].stop();
  };

  loadKeys = function() {
    var args, cb, keys, opts, _ref,
      _this = this;
    keys = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    _ref = h.argParser.apply(h, __slice.call(args).concat([{
      watch: true
    }])), opts = _ref[0], cb = _ref[1];
    keys = keys instanceof Array ? keys : [keys];
    if (etcd == null) {
      etcd = getClient();
    }
    return async.eachSeries(keys, setFromKey, function(err) {
      var key, _i, _len;
      if (err != null) {
        return typeof cb === "function" ? cb(err) : void 0;
      }
      if ((opts.watch != null) && opts.watch) {
        for (_i = 0, _len = keys.length; _i < _len; _i++) {
          key = keys[_i];
          setWatcher(key);
        }
      }
      return typeof cb === "function" ? cb() : void 0;
    });
  };

  close = function(cb) {
    var key,
      _this = this;
    return async.eachSeries((function() {
      var _results;
      _results = [];
      for (key in watchers) {
        _results.push(key);
      }
      return _results;
    })(), stopWatcher, function(err) {
      return typeof cb === "function" ? cb() : void 0;
    });
  };

  module.exports = {
    loadKeys: loadKeys,
    close: close,
    getClient: getClient,
    watchers: watchers
  };

}).call(this);
