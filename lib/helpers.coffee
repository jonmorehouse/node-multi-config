exports.camelCase = (key) ->
  normalize = (input) ->
    input[0].toUpperCase() + input.slice(1,input.length).toLowerCase()
  
  pieces = key.split "_"
  if pieces.length > 1
    return pieces[0].toLowerCase() + (normalize piece for piece in pieces[1..pieces.length]).join ""
  else
    return pieces[0].toLowerCase()

exports.normalizeValue = (value) ->

  number = value.match /^([0-9\.]+)$/
  if number?
    return parseInt value

  array = value.split ","
  if array? and array.length > 1
    return (exports.normalizeValue value for value in array)

  return value 

exports.argParser = (args...) ->
  
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


