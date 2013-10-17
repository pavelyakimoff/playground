class Playground.Views.Developers extends Backbone.Marionette.CompositeView
  tagName: 'div'
  className: 'developers'
  template: 'developers/1_templates/developers'
  itemView: Playground.Views.Developer
  
  collectionEvents:
    'sort': 'renderCollection'
  
  events:
    'click .add': 'addNewDeveloper'

  appendHtml: (collectionView, itemView) ->
    if itemView.model.isNew() 
      console.log 'add new item to collection'
      collectionView.$("tbody").prepend(itemView.el).find('tr:first').hide().fadeIn(500)
    else
      collectionView.$("tbody").prepend(itemView.el)
    
  addNewDeveloper: ->
    console.log 'addNewDeveloper'
    model = new Playground.Models.Developer()
    form = new Playground.Views.DeveloperForm
      model: model
    $('#forms').html(form.render().el)
    
  renderCollection: ->
    this.render()

