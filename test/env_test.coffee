require './bootstrap'

env = projectRequire "env"
config = projectRequire "index"

exports.testEnv = (test) ->
  do test.done

exports.testEnvArray = (test) ->
  keys = ["HOME"]
  env.load keys

  for key in keys
    test.notEqual process.env[key]?, null
    test.notEqual config[key.toLowerCase()], null

  do test.done

exports.testEnvArrayCb = (test) ->
  env.load ["HOME"], (err) ->

    test.equal config.home?, true 
    test.equal config.HOME?, true

    do test.done

exports.testEnvSplat = (test) ->

  keys = ["HOME", "PATH"]
  delete config[key] for key in keys
  env.load "HOME", "PATH", (err) ->

    for key in keys
      test.equal config[key]?, true

    do test.done



