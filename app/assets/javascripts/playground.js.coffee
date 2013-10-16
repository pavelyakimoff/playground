#= require_self

window.Playground =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  initialize: -> 
    #alert 'Hello from Backbone!'
    @initBackboneValidation()
    
  initBackboneValidation: ->

    if Backbone.Validation
      Backbone.Validation.configure
        labelFormatter: 'label'
        
      _.extend Backbone.Validation.callbacks, 
        valid: (view, attr) ->
          input = view.$('[name='+attr+']:first')
          controls = input.closest('.controls')
          incorrectFields = controls.find('.help-block').remove().end().find('.help-block')
          controls.removeClass('error') if incorrectFields.length == 0
          
        invalid: (view, attr, error) ->
          input = view.$('[name='+attr+']:first')
          controls = input.closest('.controls')
          controls.addClass('error').find('.help-block').remove().end().append('<div class="help-block" data-for="'+attr+'">'+error+'</div>')
      
      _.extend Backbone.Validation.messages, 
        required: 'Поле {0} обязательно для заполнения'

# запускает инициализацию window.Playground
$($.proxy(Playground.initialize, Playground))

rivets.configure 
  adapter:
    subscribe: (obj, keypath, callback) ->
      obj.on 'change' + keypath, callback
    unsubscribe: (obj, keypath, callback) ->
      obj.off 'change' + keypath, callback
    read: (obj, keypath) ->
      obj.get keypath
    publish: (obj, keypath, value) ->
      obj.set keypath, value

