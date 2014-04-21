require './bootstrap'

config = projectRequire "index.coffee"

exports.testEnv = (test) ->

  do test.done

exports.testEnvArray = (test) ->

  keys = ["HOME"]
  config.loadFromEnv keys

  for key in keys
    test.notEqual process.env[key]?, null
    test.notEqual config[key.toLowerCase()], null

  do test.done


exports.testEnvArrayCb = (test) ->

  config.loadFromEnv ["HOME"], (err) ->

    test.equal config.home?, true 
    test.equal config.HOME?, true

    do test.done








