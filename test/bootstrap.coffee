path = require 'path'

baseDirectory = path.resolve path.join __dirname, ".."
fixtureDirectory = path.resolve path.join __dirname, "fixtures"

# global bootstrapped variables
# print out all call stack errors - this helps a ton!
process.on 'uncaughtException', (err) ->
  console.error err.stack

global.p = console.log
global.projectRequire = (_path) ->
  return require path.join baseDirectory, "lib", _path
global.getFixturePath = (_path) ->
  return path.resolve path.join fixtureDirectory, _path
global.getJsonFixture = (_path) ->
  return require getFixturePath _path



