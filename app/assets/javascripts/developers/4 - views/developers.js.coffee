class Playground.Views.Developers extends Backbone.Marionette.CompositeView
  tagName: 'div'
  className: 'developers'
  template: 'developers/1_templates/developers'
  itemView: Playground.Views.Developer
  
  events:
    'click .add': 'addNewDeveloper'

  appendHtml: (collectionView, itemView) ->
    collectionView.$("tbody").prepend(itemView.el)
    
  addNewDeveloper: ->
    console.log 'addNewDeveloper'
    model = new Playground.Models.Developer()
    form = new Playground.Views.DeveloperForm
      model: model
    $('#forms').html(form.render().el)
    

