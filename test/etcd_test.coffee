bootstrap = require "./bootstrap"
etcd = projectRequire "etcd"
Etcd = require 'node-etcd'

test = 

  setUp: (cb) ->

    @etcd = new Etcd process.env["ETCD_HOST"], parseInt process.env["ETCD_PORT"]
    @obj = 
      key: "value"
      obj: {age: 26, name: {first: "first_name", last: "last_name"}}
      number: 4331
      array: ["test", "test"]
    @etcd.set key, value for key, value of @obj
    etcd.loadKeys (key for key of @obj), =>
      cb?()

  tearDown: (cb) ->
  
    return cb?()
    etcd.close =>
      cb?()

  testLoadKeys: (test) ->

    # now make sure all keys exist
    for key of @obj
      test.deepEqual config[key]?, true
      test.deepEqual config[key], @obj[key]
    do test.done

  testWatch: (test) ->

    key = "key"
    #oldValue = config[key]
    #@etcd.set key, "some new value"
  
    do test.done

  testNoWatch: (test) ->

    # this should fill the values accordingly ...
    do test.done

  
