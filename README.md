# Multi Config
### Configuration manager for node.js
> bootstrap global configuration with etcd, env variables, configuration files or even manually

## Usage
### Etcd

> node config allows you to set objects and attributes via etcd

~~~ sh
$ export ETCD_HOST="localhost"
$ export ETCD_PORT=4001


$ etcdctl mkdir "node"
$ etcdctl set "node/key", "value"
$ etcdctl set "node/subdir/key", "value"

~~~

~~~ coffee-script
config = require 'multi-config'

# load configuration from etcd
config.loadKeys ["node"]

config.node
# {key: "value", subdir: {key: "value"}}

~~~

### Environment Variables
> node config allows you to set attributes and objects via environment variables

~~~ sh
$ export TEST_KEY=value
~~~

~~~ Coffee-script
config = require 'multi-config'

config.env ["TEST_KEY"] 

config.test
# {key: "value"}

config.TEST_KEY
# "value"

~~~

### Configuration Files
> node config allows you to set attributes and objects via config files

~~~ coffee-script
config = require 'multi-config'

# pass in one or multiple file paths
config.file "config.json" 

~~~


#### Supported Filetypes

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

## Manual Usage
> node config allows you to manually set config attributes

~~~ coffee-script
config = require 'multi-config'

config.set "key", "value"

config.key
# "value"
~~~



