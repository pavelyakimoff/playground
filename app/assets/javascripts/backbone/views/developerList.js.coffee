class Playground.Views.DevelopersView extends Backbone.Marionette.CompositeView
  tagName: "table"
  className: 'table'
  template: "backbone/templates/developersView"
  itemView: Playground.Views.DeveloperView
  itemViewContainer1: -> 
    console.log ".test"

  appendHtml: (collectionView, itemView) ->
    collectionView.$("tbody").append(itemView.el)

  onRender: ->
    console.log "render"