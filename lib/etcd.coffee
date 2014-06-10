Etcd = require 'node-etcd'
require "./index"
env = require "./env"
async = require 'async'
h = require "./helpers"
merge = require "./merge"

# module wide vars
etcd = null
watchers = {}

getClient = ->

    # return cached value is possible
    return etcd if etcd?

    # set up required etcd configuration
    config.etcdHost ?= env.get "ETCD_HOST", "localhost"
    config.etcdPort ?= env.get "ETCD_PORT", 4001
    config.etcdNamespace ?= env.get "ETCD_NAMESPACE", ""
    etcd = new Etcd config.etcdHost, config.etcdPort

setFromResponse = (res, cb) ->

  key = res.node.key.replace "/", ""
  if not res.node.dir? or not res.node.dir or not res.node.nodes?
    config[key] = res.node.value
    return cb?()

  keys = []
  for node in res.node.nodes
    if not node.dir? or not res.node.dir
      # add nodes for each 
      h.setObject node.key, node.value, config, /[\/]+/
      continue
    keys.push node.key
       
  async.eachSeries keys, setFromKey, (err) ->
    cb?()

setFromKey = (key, args...) ->

  _cb = null
  [opts, _cb] = h.argParser args..., {recursive: true}
  etcd.get key, (err, res) =>
    return _cb? err if err 
    counter = if res.node.nodes? then [node for node in res.node.nodes when node.dir?].length else 1

    setFromResponse res, (err) ->

      return _cb?()


setWatcher = (key, cb) ->
  
  # return if watcher already exists
  return cb?() if key of watchers

  # this is really hacky because there is something weird about the etcd library not playing nice
  _etc = new Etcd config.etcdHost, config.etcdPort
  watchers[key] = _etc.watcher key
  watchers[key].on "set", (res) ->
    setFromResponse res

  watchers[key].on "error", (res) ->

  cb?()

stopWatcher = (key,cb) ->

  return cb?() if key not of watchers
  watchers[key].on "stop", (err) =>
    delete watchers[key]
    cb?()

  watchers[key].stop()

load = (args...) ->

  [keys, opts, cb] = h.splatParser args...
  opts ?= {}
  opts.recursive ?= true
  etcd ?= getClient()

  async.eachSeries keys, setFromKey, (err) =>
    return cb? err if err?
    
    if opts.watch? and opts.watch
      setWatcher key for key in keys

    # normalize the namespace for etcd directories ... this should be easier ...
    if opts.namespace? and not opts.namespace
      for key in keys
        _val = config[key]
        merge _val
        if not _val[key]?
          delete config[key]

    cb?()
    
close = (cb) ->

  #close all existing watchers
  async.eachSeries (key for key of watchers), stopWatcher, (err) =>
    # close client
    cb?()

module.exports =
  load: load
  close: close
  getClient: getClient
  watchers: watchers


