global.p = console.log

global.config = {}
config.loadFilepath = require "./file"
config.loadEnv= require("./env").loadEnv
config.getEnv = require("./env").getEnv
config.set = require "./set"
config.etcd = require "./etcd"

# export the global configuration object as the parent for all interactions
module.exports = global.config


