class Playground.Models.Developer extends Backbone.Model
  paramRoot: 'developer'

  defaults:	
    name: null
    surname: null
    phone: null
   
class Playground.Collections.DevelopersCollection extends Backbone.Collection
  model: Playground.Models.Developer
  url: '/developers/json'
