camelCase = (key) ->
  normalize = (input) ->
    input[0].toUpperCase() + input.slice(1,input.length).toLowerCase()
  
  pieces = key.split "_"
  if pieces.length > 1
    return pieces[0].toLowerCase() + (normalize piece for piece in pieces[1..pieces.length]).join ""
  else
    return pieces[0].toLowerCase()

normalizeValue = (value) ->

  number = value.match /^([0-9\.]+)$/
  if number?
    return parseInt value

  array = value.split ","
  if array? and array.length > 1
    return (normalizeValue value for value in array)

  return value 

argParser = (args...) ->
  
  switch args.length

    when 0 then return [null, null]
    when 1
      # only an object passed - no callback
      if typeof args[0] == "object" 
        return [args[0], null]
      # only callback passed in - and no default given
      return [null, args[0]]
    when 2 # default parameter used because user didn't pass in an object
      if typeof args[0] == "object"  
        return [args[0], args[1]]
      # return last argument (default options) as callback
      return [args[1], args[0]]
    else return [args[0], args[1]]    

normalizeCase = (key) ->

  if key.toUpperCase() == key
    return camelCase key
  return key

setObject = (key, value, obj, delimiter) =>

  # add to the global object by default
  obj ?= config
  # by default split by commands and underscores
  delimiter ?= /[,_]+/

  # get an array of the proper pieces
  pieces = (normalizeCase(piece) for piece in key.split(delimiter))

  # recurse through the various keys
  (_recurser = (keys, pObj, value) =>
    
    if keys.length == 0
      return
    else if keys.length == 1
      pObj[keys[0]] = value
    # nested object
    else 
      if not pObj[keys[0]]? or not typeof pObj[keys[0]] == "object"
        pObj[keys[0]] = {}
      # call the next level of recursion
      return _recurser keys[1...], pObj[keys[0]], value
  )(pieces, obj, value)

  return obj

module.exports = 
  setObject: setObject
  camelCase: camelCase
  normalizeValue: normalizeValue
  normalizeCase: normalizeCase
  argParser: argParser


