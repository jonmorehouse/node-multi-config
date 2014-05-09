helpers = require "./helpers"

getEnv = (key) =>

  return helpers.normalizeValue process.env[key]

setCamelCase = (key) ->
  objKey = helpers.camelCase key
  if getEnv key?
    config[objKey] = getEnv key
    config[key] = getEnv key
  else
    err = new Error "Invalid key"
    return cb? err if cb?
    throw err

setEnv = (key) =>

  config[key] = getEnv key

setObject = (key) =>

  # split the key by its name ...
  # create the object structure as needed
  pieces = (piece.toLowerCase() for piece in key.split("_"))

  # recurse through the various keys
  (_recurser = (keys, pObj) =>
    
    if keys.length == 0
      return
    else if keys.length == 1
      pObj[keys[0]] = getEnv key
    # nested object
    else 
      if not pObj[keys[0]]? or not typeof pObj[keys[0]] == "object"
        pObj[keys[0]] = {}
      # call the next level of recursion
      return _recurser keys[1...], pObj[keys[0]]
  )(pieces, config)

module.exports = (keys, cb) ->
 
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

