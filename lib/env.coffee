camelcase = (key)->

  normalize = (input)->
    
    input[0].toUpperCase() + input.slice(1,input.length).toLowerCase()

  pieces = key.split "_"
  if pieces.length > 1
   return [pieces[0].toLowerCase() + (normalize piece for piece in pieces[1..pieces.length])].join ""
  else
    return pieces[0].toLowerCase()

module.exports = (keys, defaultValue)->

  envSetter = (key)->
    objKey = camelcase key
    if process.env[key]?
      config[objKey] = process.env[key]
      config[key] = process.env[key]
    else if not config[key]? and defaultValue?
      config[objKey] = defaultValue
    else
      throw new Error "Invalid key"

  # normalize to an array
  if not typeof keys == 'array'
    keys = [keys]
    
  # set each key properly
  envSetter key for key in keys


