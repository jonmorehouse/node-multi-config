# Node.js Config
> A configuration library that allows dynamic configuration via ENV, etcd, config-files or functionally

## Description

This package allows you to easily pass your configuration around via package. This allows you to bootstrap once and use anywhere.

## Etcd Usage 
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

config["node"] 
# {key: "value", subdir: {key: "value"}}

~~~

## Env Usage

~~~ sh

export TEST_KEY=value

config.env ["TEST_KEY"] 

config["test"]
# {key: "value"}

~~~

~~~ Coffee-script
config = require 'node-config'

# load configuration from etcd
config.loadKeys ["node"]


~~~




