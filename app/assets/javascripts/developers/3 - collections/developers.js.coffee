class Playground.Collections.Developers extends Backbone.Collection
  model: Playground.Models.Developer
  url: '/developers/json'
  
  comparator: (model) ->
    model.get('level')
