console.log 'test.js.coffee'

class SimpleView extends Backbone.View
  tagName: 'li'
  className: 'simpleView'

class SimpleModel extends Backbone.Model
  defaults:
    name: 'default'

models = []

simpleView = new SimpleView()


