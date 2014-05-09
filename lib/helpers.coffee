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


