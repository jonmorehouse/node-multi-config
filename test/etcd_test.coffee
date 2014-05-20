bootstrap = require "./bootstrap"
etcd = projectRequire "etcd"
async = require 'async'

module.exports = 

  setUp: (cb) ->

    @client = etcd.getClient()
    @obj = 
      key_test: "value2"
      obj: {age: 26, name: {first: "first_name", last: "last_name"}}
      number: "4331"
      array: ["test", "test"]

    @client.set key, value for key, value of @obj
    etcd.loadKeys (key for key of @obj), {watch: true}, =>
      cb?()

  tearDown: (cb) ->
    etcd.close ->
      cb?()

  testLoadKeys: (test) ->

    # now make sure all keys exist
    for key of @obj
      test.deepEqual config[key]?, true
      test.deepEqual config[key], @obj[key]
    do test.done

  testWatch: (test) ->
  
    # get old value
    key = "key_test"
    val = config[key]

    _ = (val, cb) =>
      @client.set key, val
      __ = =>
        test.deepEqual val, config[key]
        cb?()
      setTimeout __, 50

    async.eachSeries ["val1", "val2", "val3"], _, (err) =>    

      do test.done

  testDirectorySuite: 

    setUp: (cb) ->

      @dirName = "testDir"
      @client.mkdir @dirName, (err, res) =>
        @client.set "#{@dirName}/key", "value", (err, res) ->
          cb?()

    tearDown: (cb) ->
      @client.rmdir @dirName, {recursive: true}, (err, res) ->
        cb?()

    testDirectoryKeys: (test) -> 

      etcd.loadKeys @dirName, =>

        test.deepEqual config[@dirName], {key: "value"}
        do test.done

    testNestedDirectory: (test) -> 

      @client.set "#{@dirName}/subdir/key", "value", (err, res) =>
        etcd.loadKeys @dirName, =>

          test.deepEqual config[@dirName], {key: "value", subdir: {key: "value"}}
          do test.done

