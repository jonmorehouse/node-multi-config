require './bootstrap'

config = projectRequire "index.coffee"

exports.testSet = (test) ->
  key = "TEST_SET_KEY"
  value = "value"
  config.set key, value
  test.equal config[key], value

  do test.done

exports.testSetCb = (test) ->
  config.set "key", "value", (err) ->

    test.equals false, err?
    test.equals config.key, "value"
    do test.done

exports.testSetBySplat = (test) ->


  config.set "key", "value", "key2", "value", (err) ->

    test.equals false, err?
    test.equals config.key2?, true
    test.equals config.key2, "value"
    do test.done

exports.testSetBySplat = (test) ->

  config.set ["key3", "value"], ["key4", "value"]
  test.equals true, config.key3?
  test.equals "value", config.key3

  do test.done






