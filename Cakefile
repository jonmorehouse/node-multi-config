nodeunit = require 'nodeunit'
global.p = console.log

task "test", "Run all tests", ->

  reporter = nodeunit.reporters.verbose
  reporter.run ["test"]


task "debug", "Run temporary debugger", ->

  config = require './lib/index'
  config.loadFilepath "test/fixtures/test.cson", (err, obj)->

    p err
    p obj

