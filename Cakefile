nodeunit = require 'nodeunit'
global.p = console.log
{spawn} = require 'child_process'
{print} = require 'sys'

task "test", "Run all tests", ->

  reporter = nodeunit.reporters.verbose
  reporter.run ["test"]

task "build", "Build jslib", ->

  coffee = spawn 'coffee', ['-c', '-o', 'jslib', 'lib']
  coffee.stderr.on 'data', (data)->

  coffee.stdout.on 'data', (data)->
    print data.toString()

task "debug", "Run temporary debugger", ->

  config = require './lib/index'
  config.loadFilepath "test/fixtures/test.cson", (err, obj)->

    p err
    p obj

