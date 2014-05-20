global.p = console.log

global.config = {}

config.file = require("./file").load
config.env= require("./env").load
config.etcd = require("./etcd").load
config.set = require("./set")

# export the global configuration object as the parent for all interactions
module.exports = global.config

