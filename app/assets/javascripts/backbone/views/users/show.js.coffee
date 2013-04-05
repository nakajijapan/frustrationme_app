BackboneFrustration.Views.Users ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Users.ShowView extends Backbone.View
  el: $("#users_show")
  #events:

  #------------------------
  initialize: () ->
    # イベントの追加
    #@delegateEvents(@events)
    @initialize_grid()

  initialize_grid: () ->
    options =
      autoResize: true
      container: $('.items')
      offset: 2
      item_width: 210

    console.log options

    $('.item').CoolGrid(options)