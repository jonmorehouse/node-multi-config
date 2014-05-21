h = require "./helpers"

get = (key, defaultValue) =>

  if key not of process.env
    return defaultValue

  return h.normalizeValue process.env[key]

setObject = (key) ->

  h.setObject key, get(key), config, "_"

setCamelCase = (key) ->

  objKey = h.camelCase key
  if process.env[key]?
    config[objKey] = get key
    config[key] = get key
  else
    err = new Error "Invalid key"
    return cb? err if cb?
    throw err

setEnv = (key, defaultValue) =>

  config[key] = get key


load = (args...) ->
  
  [keys, opts, cb] = h.splatParser args...

  # set each key properly
  ((key) => 
    setCamelCase key
    setObject key
    setEnv key
  )(key) for key in keys

  return cb?()

module.exports =
  load: load
  get: get



