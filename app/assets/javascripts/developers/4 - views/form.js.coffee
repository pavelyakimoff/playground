class Playground.Views.DeveloperForm extends Backbone.Marionette.ItemView
  className: 'editForm'
  template: 'developers/1_templates/form'
  
  events:
    'click .save': 'saveModel'
    'click .close': 'closePopup'
  
  initialize: ->
  
  onRender: ->    
    # rivets-binding
    @rivets = rivets.bind(@el,
      developer: @model
    )
    
  onClose: ->
    console.log 'onClose'
    @rivets.unbind()
    
  saveModel: (ev) ->
    ev.preventDefault()
    console.log 'saveModel'
    modal = this.$el.find('#editForm')
    modal.on('hidden', @closePopup())
    Playground.App.collection.add(this.model) if this.model.isNew()
    this.model.save()
    modal.modal('hide')
    
  closePopup: ->
    console.log 'closePopup'
    @close()
