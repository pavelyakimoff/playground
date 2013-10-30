Workspace.Views.SimpleListItem = Backbone.View.extend({

  tagName: 'li',
  className: 'b-side-list__item',

  events: {
    'click': 'onClick'
  },

  initialize: function() {
    this.modelBinder = new Backbone.ModelBinder();
  },

  render: function(template) {

    JST[this.options.template](this.model.toJSON(), $.proxy(function(error, out){
      this.$el.html(out);
    }, this));

    if ( this.model.get('hidden') || this.model.get('is_hidden') ) {
      this.$el.addClass('b-side-list__item_deleted');
    }

    this.$el.data('item-id', this.model.id).attr('item-id', this.model.id);

    this.modelBinder.bind(this.model, this.el);

    return(this.$el);

  },

  onClick: function() {
    $('#list li.b-side-list__item_active').removeClass('b-side-list__item_active');
    this.$el.addClass('b-side-list__item_active');

    this.model.view = new Workspace.Views.SimpleForm({
      template: Workspace.App.options.name+'/1 - templates/form',
      model: new Workspace.App.options.model(this.model.toJSON())
    });
    $('#form').html(this.model.view.render());
    this.model.view.$('input[type="text"]:first').focus();

    Workspace.App.router.navigate('/' + this.model.get('id'));

  },

  hide: function(){
    this.$el.hide();
  },

  show: function(){
    this.$el.show();
  }

});
