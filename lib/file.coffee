path = require 'path'
cson = require 'coffeeson'
yaml = require 'js-yaml'
merge = require './merge'

yamlLoader = (filepath, cb)->
  try
    obj = yaml.safeLoad filepath
  catch err
    return cb err
  return cb null, obj

jsonLoader = (filepath, cb)->
  try
    obj = require filepath
  catch err
    return cb err
  cb null, obj

module.exports = (filepath, opts, cb)->

  if not cb?
    cb = opts
    opts = {}

  switch path.extname filepath
    when ".json" then loader = jsonLoader
    when ".cson" then loader = cson
    when ".yml", ".yaml" then loader = ymlLoader
    else
      return cb new Error "Unrecognized file type"

  loader filepath, (err, obj)->
    return cb err if err
    merge obj, opts
    cb null, obj


