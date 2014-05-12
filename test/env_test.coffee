require './bootstrap'

config = projectRequire "index.coffee"

exports.testEnv = (test) ->
  do test.done

exports.testEnvArray = (test) ->
  keys = ["HOME"]
  config.loadEnv keys

  for key in keys
    test.notEqual process.env[key]?, null
    test.notEqual config[key.toLowerCase()], null

  do test.done

exports.testEnvArrayCb = (test) ->
  config.loadEnv ["HOME"], (err) ->

    test.equal config.home?, true 
    test.equal config.HOME?, true

    do test.done








