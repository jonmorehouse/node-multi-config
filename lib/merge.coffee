extend = require 'extend'

module.exports = (obj, opts) ->

  if not opts? 
    deep = false
  else if typeof opts == 'boolean'
    deep = opts
  else if typeof opts == 'object' and opts.deep?
    deep = opts.deep
  else
    deep = false

  # now merge the object properly into the global space 
  extend deep, global.config, obj
  

