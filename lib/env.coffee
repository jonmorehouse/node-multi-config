helpers = require "./helpers"

module.exports = (keys, cb) ->
  envSetter = (key) ->
    objKey = helpers.camelCase key
    if process.env[key]?
      config[objKey] = process.env[key]
      config[key] = process.env[key]
    else
      err = new Error "Invalid key"
      return cb? err if cb?
      throw err
 
  # normalize to an array
  if not typeof keys == 'array'
    keys = [keys]
    
  # set each key properly
  envSetter key for key in keys

  return cb?()


