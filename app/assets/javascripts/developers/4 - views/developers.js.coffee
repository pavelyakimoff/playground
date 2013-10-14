class Playground.Views.Developers extends Backbone.Marionette.CompositeView
  tagName: 'table'
  className: 'table'
  template: 'developers/1_templates/developers'
  itemView: Playground.Views.Developer

  appendHtml: (collectionView, itemView) ->
    collectionView.$("tbody").append(itemView.el)
    

