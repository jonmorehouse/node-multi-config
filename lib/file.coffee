path = require 'path'
merge = require "./merge"
h = require "./helpers"
fs = require 'fs'
async = require 'async'

yamlLoader = (filepath, cb) ->

  yaml = require 'js-yaml'
  fs.readFile filepath, "utf-8", (err, str) ->
   
    cb? err if err?
    try
      obj = yaml.safeLoad str
    catch err
      return cb err
    return cb null, obj

jsonLoader = (filepath, cb) ->
  try
    obj = require filepath
  catch err
    return cb err
  cb null, obj

csonLoader = (filepath, cb) ->
  cson = require 'coffeeson'
  cson filepath, cb

load = (args...) ->

  # normalize arguments
  [filepaths, opts, cb] = h.splatParser args...

  # method runner for each path string
  _ = (filepath, cb) ->

    switch path.extname filepath
      when ".json" then loader = jsonLoader
      when ".cson" then loader = csonLoader
      when ".yml", ".yaml" then loader = yamlLoader
      else
        return cb new Error "Unrecognized file type"

    loader filepath, (err, obj) ->
      return cb err if err
      merge obj, opts
      cb null, obj

  async.each filepaths, _, (err) ->
    cb?()

module.exports = 
  load: load


