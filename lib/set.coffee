h = require "./helpers"

module.exports = (args...) ->
  
  [args, opts, cb] = h.splatParser args...
  # opts are not permitted for this method, to make life easier just append to the args
  if opts? then args.push opts
  
  for arg, index in args
    if index % 2 == 0 then key = arg
    else if key? # set this value
      config[key] = arg
      key = null
  
  cb?()



