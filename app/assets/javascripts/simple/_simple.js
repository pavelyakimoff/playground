//= require ./../vendors/backbone/backbone.modelbinder
//= require ./../vendors/backbone/backbone.extend
//= require ./../vendors/scroll

//= require_tree ./../filter

//= require ./_router
//= require_tree .

Workspace.App = {

  initialize: function(options) {

    this.options = options;

    var Collection = Workspace.Collections.SimpleList.extend({
      model: this.options.model
    });

    this.collection = new Collection(null, {
      comparator: this.options['comparator'] || function() {}
    });

    this.collection.add(this.options.source);

    this.router = new Workspace.Router;

    new Workspace.Views.Filter({
      collection: this.collection,
      view: 'listItemView',
      attrs: this.options.searchFields
    });

    this.newForm();

    this.localInitialize();

    Backbone.history.start({ root: '/' + this.options.name });
    Backbone.Faye.bind('/' + Workspace.App.options.name, this.collection, { modelName: Workspace.App.options.modelName });

    $('.b-side-list').addClass('js-scrollpane js-scrollpane_left js-scrollpane_with-shadow');
    $(window).on('resize', $.proxy(this.onResize, this));
    this.onResize();
    Workspace.setCustomScrolls();

  },

  onResize: function() {
    $('.b-side-list').height($(window).height() - $('.b-side-list').position().top - 30);
  },

  // Функция для расширения локально
  localInitialize: function(){},

  newForm: function() {
    $('#list li.b-side-list__item_active').removeClass('b-side-list__item_active');
    var newForm = new Workspace.Views.SimpleForm({
      model: new this.options.model,
      template: this.options.name + '/1 - templates/form'
    });
    $('#form').html(newForm.render());
    newForm.$('input[type="text"]:first').focus();
  }

};
