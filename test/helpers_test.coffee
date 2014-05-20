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


exports.setObject = (test) ->

  testCases = [
    {
      key: "testDir/key"
      value: "value"
      delimiter: "/"
      result: {testDir: {key: "value"}}
    },
    {
      key: "testDir/testDir/key"
      value: "value"
      delimiter: "/"
      result: {testDir: {testDir: {key: "value"}}}
    },
    {
      key: "key"
      value: "value"
      delimiter: "_"
      result: {key: "value"}
    },
    {
      key: "testDir_testDir_key"
      value: "value"
      delimiter: undefined
      result: {testDir: {testDir: {key: "value"}}}
    }
  ]

  for tc in testCases
    obj = h.setObject tc.key, tc.value, {}, tc.delimiter
    test.deepEqual obj, tc.result

  test.done()

exports.splatParser = (test) ->
  
  # only string arguments
  test.deepEqual h.splatParser("arg1", "arg2"), [["arg1", "arg2"], null, null] 
  # string and array arguments, options and a callback function
  test.deepEqual h.splatParser(["arg1", "arg2"], "arg3", {}, test.done), [["arg1", "arg2", "arg3"], {}, test.done]

  do test.done


