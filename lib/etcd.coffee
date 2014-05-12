Etcd = require 'node-etcd'
env = require "./env"
async = require 'async'
h = require "./helpers"

# module wide vars
etcd = null
watchers = {}

getEtcd = ->

    # return cached value is possible
    return etcd if etcd?

    # set up required etcd configuration
    config.etcdHost ?= env.getEnv "ETCD_HOST", "localhost"
    config.etcdPort ?= env.getEnv "ETCD_PORT", 4001
    config.etcdNamespace ?= env.getEnv "ETCD_NAMESPACE", ""
    etcd = new Etcd config.etcdHost, config.etcdPort
    return etcd

setFromKey = (key, args...) ->
  [cb, opts] = h.argParser args...
  etcd.get key, {recursive: true}, (err, res) =>
    return cb? err if err
    return cb? new Error "No value for #{key}" if not res? or not res.value?
    config[key] = res.value
    cb?()

setWatcher = (key) ->
  
  return 
  # return if watcher already exists
  return if key of watchers

  # now create a new watcher
  watcher = etcd.watcher key
  watcher.on "change", (err, value) ->

    p "change"

exports.loadKeys = (keys, args...) ->

  # bootstrap scope
  cb = args[args.length - 1]
  opts = if args.length > 1 then args[0] else {watch: true}
  keys = if keys instanceof Array then keys else [keys]
  etcd ?= getEtcd()

  # grab each key in parallel from etcd
  async.eachSeries keys, setFromKey, (err) =>
    return cb? err if err?

    # check key exists and check that it is true before setting up a watcher 
    #if opts.watch? and opts.watch
      #setWatcher key for key in keys

    cb?()
    
exports.close = (cb) ->

  # close all existing watchers
  #watcher.close() for watcher, value of watchers

  # close client
  
  cb?()


