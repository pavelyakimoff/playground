class Playground.Views.DeveloperView extends Backbone.Marionette.ItemView
  tagName: 'tr'
  className: 'developerInfo'
  template: "backbone/templates/developerView"
  
  initialize:  ->
    this.$el.delegate('.delete','click', @deleteDeveloper)

  # event-functions
  deleteDeveloper: =>
    this.model.delete()
    this.$el.fadeOut(3000, (item) => this.remove() )

  onBeforeRender: ->
    console.log this

  serializeData: ->
    console.log @model.toJSON()
    @model.toJSON()

  ###render: ->
    tmpl = _.template(this.template)
    this.$el.html(tmpl(this.model.toJSON()))###