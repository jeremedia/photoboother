#= require cable
#= require_self
#= require_tree .

@App = {}
App.cable = Cable.createConsumer 'ws://0.0.0.0:28080'
