Node.js Config
==============

Functionality
-------------

Supported FileTypes
-------------------

* cson
* env
* json
* yaml

Functions
--------

* loadFromPath(filepath, opts, cb)
* loadFromEnv([])

Example
-------

```
config = require 'node-config'

config.loadFromEnv ["HOME", "ENV"], (err)->
  

```

