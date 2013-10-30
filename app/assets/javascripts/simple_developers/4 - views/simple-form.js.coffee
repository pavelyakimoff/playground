class Workspace.Views.SimpleForm extends Backbone.View 
  tagName: 'form'
  className: 'form-horizontal b-form'
    
  events: 
    'submit': 'submit'
    'click .b-form__clear': 'clear'
    'click .b-form__delete': 'delete'

  initialize: ->
    @modelBinder = new Backbone.ModelBinder()

  render: ->
    data = if this.model then this.model.toJSON() else {}
    data.isNew = this.model.isNew()

    JST[this.options.template](data, $.proxy( (error, out) => this.$el.html(out) ) )

    this.$el.data('item-id', this.model.id).attr('item-id', this.model.id)

    this.modelBinder.bind(this.model, this.el)

    this.$el 

  submit: =>
    collection = Workspace.App.collection

    Backbone.Validation.bind(this)
    this.model.validate()

    if this.model.isValid()
      if this.model.isNew()
        model = this.model

        conf =
          wait: true
          success: (model, response) ->
            model.listItemView.render()
            model.listItemView.$el.click()
          error: (model, response) ->
            message = 'Не удалось добавить ' + Workspace.App.options.modelName
            message = Workspace.parseResponseErrors(message, response)
            Workspace.growlMessage({text: message})

        collection.create model, conf

      else
        model = collection.get(this.model.get('id'))

        conf = 
          wait: true
          success: $.proxy( (model) =>  model.listItemView.render() )
          error: (model,response) ->
            message = 'Не удалось изменить ' + Workspace.App.options.modelName
            message = Workspace.parseResponseErrors(message, response)
            Workspace.growlMessage({text: message})

        console.log model
        model.save(this.model.toJSON(), conf)

    Backbone.Validation.unbind(this)

    return false 

  clear: =>
    this.$el[0].reset()

  delete: =>
    if confirm('Точно удалить?')
      Workspace.App.collection.remove(this.model)
      this.model.remove()
