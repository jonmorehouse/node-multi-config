// Generated by CoffeeScript 1.6.3
(function() {
  var Etcd, async, env, etcd, getEtcd, h, setFromKey, setWatcher, watchers,
    __slice = [].slice;

  Etcd = require('node-etcd');

  env = require("./env");

  async = require('async');

  h = require("./helpers");

  etcd = null;

  watchers = {};

  getEtcd = function() {
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
    etcd = new Etcd(config.etcdHost, config.etcdPort);
    return etcd;
  };

  setFromKey = function() {
    var args, cb, key, opts, _ref,
      _this = this;
    key = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    _ref = h.argParser.apply(h, args), cb = _ref[0], opts = _ref[1];
    return etcd.get(key, {
      recursive: true
    }, function(err, res) {
      if (err) {
        return typeof cb === "function" ? cb(err) : void 0;
      }
      if ((res == null) || (res.value == null)) {
        return typeof cb === "function" ? cb(new Error("No value for " + key)) : void 0;
      }
      config[key] = res.value;
      return typeof cb === "function" ? cb() : void 0;
    });
  };

  setWatcher = function(key) {
    var watcher;
    return;
    if (key in watchers) {
      return;
    }
    watcher = etcd.watcher(key);
    return watcher.on("change", function(err, value) {
      return p("change");
    });
  };

  exports.loadKeys = function() {
    var args, cb, keys, opts,
      _this = this;
    keys = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    cb = args[args.length - 1];
    opts = args.length > 1 ? args[0] : {
      watch: true
    };
    keys = keys instanceof Array ? keys : [keys];
    if (etcd == null) {
      etcd = getEtcd();
    }
    return async.eachSeries(keys, setFromKey, function(err) {
      if (err != null) {
        return typeof cb === "function" ? cb(err) : void 0;
      }
      return typeof cb === "function" ? cb() : void 0;
    });
  };

  exports.close = function(cb) {
    return typeof cb === "function" ? cb() : void 0;
  };

}).call(this);
