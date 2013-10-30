Workspace.Views.SimpleForm = Backbone.View.extend({

  tagName: 'form',
  className: 'form-horizontal b-form',

  events: {
    'submit':                   'submit',
    'click .b-form__clear' :    'clear',
    'click .b-form__delete' :    'delete'
  },

  initialize: function() {
    this.modelBinder = new Backbone.ModelBinder();
  },

  render: function() {
    var data = this.model ? this.model.toJSON() : {};

    data.isNew = this.model.isNew();

    JST[this.options.template](data, $.proxy(function(error, out){
      this.$el.html(out);
    }, this));

    this.$el.data('item-id', this.model.id).attr('item-id', this.model.id);

    this.modelBinder.bind(this.model, this.el);

    return(this.$el);
  },

  clear: function(){
    this.$el[0].reset()
  },

  submit: function() {

    var message, model, collection = Workspace.App.collection;

    Backbone.Validation.bind(this);
    this.model.validate();

    if( this.model.isValid() ) {

      if( this.model.isNew() ) {

        model = this.model;
        collection.create(model, {
          wait: true,
          success: function(model, response) {

            model.listItemView.render();
            model.listItemView.$el.click();
            //message = Workspace.App.options.modelName + ' создан.';

          }, error: function(model, response){

            var message = 'Не удалось добавить ' + Workspace.App.options.modelName;
            message =  Workspace.parseResponseErrors(message, response);
            Workspace.growlMessage({
              text: message
            });

          }
        });

      } else {

        model = collection.get(this.model.get('id'));
        model.save(this.model, {
          wait: true,
          success: function(model) {
              // message = Workspace.App.options.modelName + ' изменен.'
          },
          error: function(model, response){

              var message = 'Не удалось изменить ' + Workspace.App.options.modelName;
              message =  Workspace.parseResponseErrors(message, response);
              Workspace.growlMessage({
                text: message
              });

          }
        });

      }

    }

    Backbone.Validation.unbind(this);

    return(false);
  },

  delete: function(){
    if (confirm("Точно удалить?")) {

      Workspace.App.collection.remove(this.model);
      this.model.remove();

    }
  }

});
