class Playground.Views.DevelopersView extends Backbone.Marionette.CompositeView
  tagName: 'table'
  className: 'table'
  template: 'developers/templates/developersView'
  itemView: Playground.Views.DeveloperView

  appendHtml: (collectionView, itemView) ->
    collectionView.$("tbody").append(itemView.el)
