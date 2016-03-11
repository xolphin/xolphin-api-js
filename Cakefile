{spawn} = require 'child_process'

task 'build', "Build library", ->
	coffee = spawn 'coffee', ['-cb', '-o', './lib', './src']
	coffee.stderr.on 'data', (data) -> console.log data.toString()
	coffee.stdout.on 'data', (data) -> console.log data.toString()

task 'buildwin', "Build library", ->
	coffee = spawn 'coffee.cmd', ['-cb', '-o', './lib', './src']
	coffee.stderr.on 'data', (data) -> console.log data.toString()
	coffee.stdout.on 'data', (data) -> console.log data.toString()