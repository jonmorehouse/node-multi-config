module.exports = (key, value, cb)->

  config[key] = value
  cb?()


