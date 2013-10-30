Workspace.Router = Backbone.Router.extend({

  routes: {
    ':id': 'setItem'
  },

  setItem: function(id) {
    if ( Workspace.App.collection.get(id) ) Workspace.App.collection.get(id).listItemView.$el.click();
  }

});
