Workspace.Collections._extend = {

  setEmptyMode: function(selector, message) {
    message = message || 'Список пуст';
    selector = $(selector || '#list');

    selector.append($('<li/>', {
      'class': 'b-side-list__item b-side-list__item_empty',
      text: message
    }));

  },

  setFilledMode: function(selector) {
    selector = $(selector || '#list');
    selector.find('.b-side-list__item_empty').remove();
  },

  // Устанавливает всем моделям коллекции порядок соответственно тому, как они показываются в списке
  setSortOrder: function(items) {
    items = items ? $(items) : $('#list li');
    if(items.length){
      items.each($.proxy(function(index, item){
        var itemId = $(item).attr('data-item-id') || $(item).attr('item-id');
        var collectionItem = this.get(itemId);
        collectionItem.set({ index: index, position: index}, {silent: true});
      }, this));
    }
  }

};

Workspace.Collections.SimpleList = Backbone.QueryCollection.extend({

  initialize: function() {
    this.on('add', $.proxy(this.onAddItem, this));
    this.on('remove', $.proxy(this.onRemoveItem, this));

    if ( $('#list').length ) this.setEmptyMode();

  },

  onRemoveItem: function() {
    if ( !this.length ) this.setEmptyMode();
  },

  onAddItem: function(model) {
    model.listItemView = new Workspace.Views.SimpleListItem({
      model: model,
      template: Workspace.App.options.name+'/1 - templates/list-item'
    });
    model.listItemView.addToSortedList('#list', 'listItemView');

    this.setFilledMode();

  }

});

Workspace.Collections.SimpleList = Workspace.Collections.SimpleList.extend(Workspace.Collections._extend);
