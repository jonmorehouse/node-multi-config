require "./bootstrap"
config = projectRequire "index.coffee"
file = projectRequire "file"
cson = require 'coffeeson'
yaml = require 'js-yaml'

exports.csonFile = (test) ->
  file.load getFixturePath("test.cson"), (done) ->

    test.equal config.csonKey?, true
    test.equal config.csonKey, "value"

    do test.done

exports.jsonFile = (test) ->

  file.load getFixturePath("test.json"), (done) ->
    
    test.equal config.jsonKey?, true
    test.equal config.jsonKey, "value"

    do test.done

exports.yamlFile = (test) ->

  file.load getFixturePath("test.yml"), (done) ->

    test.equal config.yamlKey?, true
    test.equal config.yamlKey, "value"

    do test.done

exports.multipleLoader = (test) ->

  keys = ["jsonKey", "csonKey", "yamlKey"]
  files = (getFixturePath(_file) for _file in ["test.yml", "test.json", "test.cson"])

  # clean up old tests
  delete config[key] for key in keys

  file.load files..., (err) ->

    for key in keys
      test.equal config[key]?, true
      test.equal config[key], "value"
    do test.done














    

