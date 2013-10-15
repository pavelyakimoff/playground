class Playground.Views.DeveloperForm extends Backbone.Marionette.ItemView
  className: 'editForm'
  template: 'developers/1_templates/form'
  
  events:
    'click .save': 'saveModel'
    'click .close': 'closePopup'
  
  initialize: ->
    Backbone.Validation.bind(this, this.model)
    console.log 'initialize form'
    console.log this
  
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
    
    console.log this.model.validate()
    
    if this.model.isValid()
      console.log 'saveModel'
      modal = this.$el.find('#editForm')
      modal.on('hidden', @closePopup())
      Playground.App.collection.add(this.model) if this.model.isNew()
      this.model.save()
      modal.modal('hide')
    else
      console.log 'validation errors!'
    
  closePopup: ->
    console.log 'closePopup'
    @close()
