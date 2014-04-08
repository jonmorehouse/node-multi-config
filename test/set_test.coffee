require './bootstrap'

config = projectRequire "index.coffee"

exports.testSet = (test)->

  key = "TEST_SET_KEY"
  value = "value"
  config.set key, value
  test.equal config[key], value

  do test.done






