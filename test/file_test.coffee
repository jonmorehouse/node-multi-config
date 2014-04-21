require "./bootstrap"
config = projectRequire "index.coffee"
cson = require 'coffeeson'
yaml = require 'js-yaml'

exports.loadCsonFile = (test) ->

  config.loadFilepath getFixturePath("test.cson"), (done) ->
    json = getJsonFixture "test.json"
    for key of json
      test.equal config[key]?, true
      test.equal config[key], json[key]
    do test.done


