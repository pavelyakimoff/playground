class Playground.Views.Developer extends Backbone.Marionette.ItemView
  tagName: 'tr'
  className: 'developerInfo'
  template: "developers/1_templates/developer"
  
  initialize: ->
    this.$el.delegate('.delete','click', @deleteDeveloper)

  # event-functions
  deleteDeveloper: =>
    this.model.delete()
    this.$el.fadeOut 3000, (item) => this.remove()

  serializeData: ->
    this.model.toJSON()
