class Playground.Views.DeveloperForm extends Backbone.Marionette.ItemView
  className: 'editForm'
  template: 'developers/1_templates/form'
  
  events:
    'click .save': 'saveModel'
    'click .close': 'clickClose'
  
  initialize: ->
    Backbone.Validation.bind(this, this.model)
    console.log 'initialize form'
  
  onRender: ->    
    # rivets-binding
    window.test = rivets.bind @el, {developer: @model}
    console.log window.test.bindings
    
  clickClose: ->
    console.log 'clickClose'
    console.log 'DeveloperForm closed'
    @close()
  
  onClose: ->
    console.log 'onClose'
    window.test.unbind()
    console.log window.test.bindings
    
  saveModel: (ev) ->
    ev.preventDefault()
    console.log 'saveModel'
    console.log 'validate model...'
    if this.model.isValid(true) 
      console.log 'model is valid!'
      this.model.save()
      Playground.App.collection.add(this.model) if this.model.isNew()
      @closePopup()
    else
      console.log 'validation errors!'
    
  closePopup: ->
    console.log 'closePopup'
    modal = this.$el.find('#editForm')
    modal.on 'hidden', => 
      console.log 'DeveloperForm closed'
      @close()
    modal.modal('toggle')
