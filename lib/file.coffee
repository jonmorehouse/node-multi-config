path = require 'path'
cson = require 'coffeeson'
yaml = require 'js-yaml'
merge = require "./merge"
h = require "./helpers"
async = require 'async'

yamlLoader = (filepath, cb) ->
  try
    obj = yaml.safeLoad filepath
  catch err
    return cb err
  return cb null, obj

jsonLoader = (filepath, cb) ->
  try
    obj = require filepath
  catch err
    return cb err
  cb null, obj

load = (args...) ->

  # normalize arguments
  [opts, cb] = h.argParser args, {}
  #filepaths = if typeof filepaths[0] is Array then filepaths[0] else filepaths


  return cb?()
  # 
  _ = (filepath, cb) ->

    switch path.extname filepath
      when ".json" then loader = jsonLoader
      when ".cson" then loader = cson
      when ".yml", ".yaml" then loader = ymlLoader
      else
        return cb new Error "Unrecognized file type"

    loader filepath, (err, obj) ->
      return cb err if err
      merge obj, opts
      cb null, obj

  async.each filepaths, 

module.exports = 
  load: load


