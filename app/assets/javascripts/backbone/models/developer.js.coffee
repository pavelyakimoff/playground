class Playground.Models.Developer extends Backbone.Model
  paramRoot: 'developer'

  defaults: 
    name: null
    surname: null
    phone: null

  urlRoot: '/developers'

  delete: ->
    this.destroy()
    console.log 'deleted in model'
   
class Playground.Collections.DeveloperCollection extends Backbone.Collection
  model: Playground.Models.Developer
  url: '/developers/json'
