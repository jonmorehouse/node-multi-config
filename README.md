# Node.js Config

## Functionality

# Supported FileTypes

* cson
* env
* json
* yaml

# Functions

* loadFromPath(filepath, opts, cb)
* loadFromEnv([])

Usage

~~~ coffee-script
config = require 'node-config'

config.loadFromEnv ["HOME", "ENV"], (err)->

  
config.set "key", "value"

console.log config.home
console.log config.HOME
console.log config.key
~~~


