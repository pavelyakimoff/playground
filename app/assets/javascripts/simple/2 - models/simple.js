Backbone.RelationalModel = Backbone.RelationalModel.extend({

  highlight: function() {

    if ( this.listItemView ) {

      var thisEl = this.listItemView.$el;

      // Полупрозрачность элемента должна определяться только классами css, а не inline стилями
      // В модели функция  highlight должна вызываться всегода после setAccess, так как последняя может установить начальную полупрозрачность

      var style = thisEl.attr('style');
      if(style){
        var opacityRegexp = /opacity:[^;]+/i;
        var style = style.replace(opacityRegexp, "");
        thisEl.attr('style', style);
      }
      var initialOpacity = thisEl.css('opacity');
      thisEl
        .animate({opacity: 0.25}, 200)
        .animate({opacity: 1}, 200)
        .animate({opacity: 0.25}, 200)
        .animate({opacity: initialOpacity}, 200);

    }
  }

});

Workspace.Models.Simple = Backbone.RelationalModel.extend({

  relocate: function() {
    if ( this.listItemView ) this.listItemView.addToSortedList('#list', 'listItemView');
  },

  setAccess: function() {
    if ( this.listItemView ) {
      if ( this.get('hidden') || this.get('is_hidden') ) this.listItemView.$el.addClass('b-side-list__item_deleted'); else this.listItemView.$el.removeClass('b-side-list__item_deleted');
    }
  },

  remove: function(){

    $('#form [item-id='+this.id+']').remove();
    $('#list li[item-id='+this.id+']').remove();

    this.destroy();
    Workspace.App.newForm();

  }

});

