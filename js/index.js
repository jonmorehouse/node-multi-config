// Generated by CoffeeScript 1.7.1
(function() {
  global.p = console.log;

  global.config = {};

  config.file = require("./file").load;

  config.env = require("./env").load;

  config.etcd = require("./etcd").load;

  config.set = require("./set");

  module.exports = global.config;

}).call(this);