class Playground.Views.DeveloperView extends Backbone.Marionette.ItemView
  tagName: 'tr'
  className: 'developerInfo'
  template: "developers/templates/developerView"
  
  initialize: ->
    #this.$el.delegate('.delete','click', @deleteDeveloper)

  # event-functions
  deleteDeveloper: ->
    this.model.delete()
    this.$el.fadeOut 3000, (item) => this.remove()

  serializeData: ->
    this.model.toJSON()

  render: ->
    tmpl = _.template(this.template)
    this.$el.html(tmpl(this.model.toJSON()))
