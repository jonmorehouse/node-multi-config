h = require "./helpers"

getEnv = (key, defaultValue) =>

  if key not of process.env
    return defaultValue

  return h.normalizeValue process.env[key]

setObject = (key) ->

  h.setObject key, getEnv(key), config, "_"

setCamelCase = (key) ->

  objKey = h.camelCase key
  if process.env[key]?
    config[objKey] = getEnv key
    config[key] = getEnv key
  else
    err = new Error "Invalid key"
    return cb? err if cb?
    throw err

setEnv = (key, defaultValue) =>

  config[key] = getEnv key


loadEnv = (keys, cb) ->
 
  # normalize to an array
  if not typeof keys == 'array'
    keys = [keys]
    
  # set each key properly
  ((key) => 
    setCamelCase key
    setObject key
    setEnv key
  )(key) for key in keys

  return cb?()

module.exports =
  loadEnv: loadEnv
  getEnv: getEnv



