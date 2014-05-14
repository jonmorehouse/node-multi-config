require './bootstrap'
h = projectRequire "helpers"

exports.testCamelCase = (test) ->
  
  key = "THREE_PIECE_KEY"
  test.equals h.camelCase(key), "threePieceKey"
  
  key = "ONEPIECEKEY"
  test.equals h.camelCase(key), "onepiecekey"

  do test.done


exports.normalizeValue = (test) ->

  nv = h.normalizeValue
  test.equal 4553, nv "4553"
  test.equal "4553a", nv "4553a"
  test.deepEqual [4,4,4], nv "4,4,4"
  test.equal "ASDF", nv "ASDF"

  do test.done


exports.normalizeArgs = (test) ->

  defs = {type: "defaults"}
  [opts, cb] = h.argParser test.done, defs
  test.equal "object", typeof opts
  test.equal "function", typeof cb
  test.deepEqual defs, opts

  [opts, cb] = h.argParser {}, test.done, defs
  test.equal "object", typeof opts
  test.equal "function", typeof cb
  test.deepEqual opts, {}

  do test.done

