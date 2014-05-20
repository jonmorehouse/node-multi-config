# Node.js Config
> A configuration library that allows dynamic configuration via ENV, etcd, config-files or functionally

## Description

This package allows you to easily pass your configuration around via package. This allows you to bootstrap once and use anywhere.

## Etcd Usage 

> node config allows you to set objects and attributes via etcd

~~~ sh
$ export ETCD_HOST="localhost"
$ export ETCD_PORT=4001


$ etcdctl mkdir "node"
$ etcdctl set "node/key", "value"
$ etcdctl set "node/subdir/key", "value"

~~~

~~~ coffee-script
config = require 'node-config'

# load configuration from etcd
config.loadKeys ["node"]

config.node
# {key: "value", subdir: {key: "value"}}

~~~

## Env Usage
> node config allows you to set attributes and objects via environment variables

~~~ sh
$ export TEST_KEY=value
~~~

~~~ Coffee-script
config = require 'node-config'

config.env ["TEST_KEY"] 

config.test
# {key: "value"}

config.TEST_KEY
# "value"

~~~

## File Usage
> node config allows you to set attributes and objects via config files

~~~ coffee-script
config = require 'node-config'

# pass in one or multiple file paths
config.file "config.json" 

~~~


### Supported Filetypes

json - http://json.org/example.html

~~~ json
// config.json
{
    "key": "value"
}
~~~

cson https://github.com/jonmorehouse/coffeeson

~~~ coffee-script
# config.cson
key: "value"
~~~

yaml http://www.yaml.org/

~~~ yaml
# config.yml
key: value
~~~

env 
~~~ bash
# config.env
KEY=value
NESTED_OBJECT=value
~~~

## Manual Usage
> node config allows you to manually set config attributes

~~~ coffee-script
config = require 'node-config'

config.set "key", "value"

config.key
# "value"
~~~



