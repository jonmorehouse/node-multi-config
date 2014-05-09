etcd = require 'node-etcd'
env = require "./env"


exports.etcd = (keys, args...) =>

  # normalize arguments
  cb = args[args.length - 1]
  opts = if args.length > 1 then args[0] else {watch: true}
  keys = if keys instanceof Array then keys else [keys]

  # now make sure we have etcd host / port as needed
  env ["ETCD_HOST", "ETCD_PORT"]

  p env.etcdHost
  p env.etcd.host
  

exports.close = =>

  # close etcd watcher if it exists





