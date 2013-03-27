BackboneFrustration.Views.Categories ||= {}

#Backbone.sync = (method, model) ->
#  alert(method + ": " + JSON.stringify(model))

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Categories.IndexView extends Backbone.View
  el: $('categories_index')
  events:
    'click .wrapper': 'test'
  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

  test:(e)->
    console.log e
