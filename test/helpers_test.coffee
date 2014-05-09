require './bootstrap'
h = projectRequire "helpers"

exports.testCamelCase = (test) ->
  
  key = "THREE_PIECE_KEY"
  test.equals h.camelCase(key), "threePieceKey"
  
  key = "ONEPIECEKEY"
  test.equals h.camelCase(key), "onepiecekey"

  do test.done

  

