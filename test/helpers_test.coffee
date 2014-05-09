require './bootstrap'
h = projectRequire "helpers"

exports.testCamelCase = (test) ->
  
  key = "THIS_HAS_FOUR_PARTS"
  p h.camelCase key

  do test.done

  

