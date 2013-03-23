BackboneFrustration.Views.Fumans ||= {}


#$.event.add(window, "load", () ->
#  console.log 'onload'
#  $('li.item').CoolGrid()
#)

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Fumans.IndexView extends Backbone.View

  #events:
  #  'keyup': 'short_cut'

  #------------------------
  initialize: () ->
    # イベントの追加
    #@delegateEvents(@events)
    console.log 'options'

    @auto_height()
    return


  auto_height: () ->
    options  =
      auto_resize: true
      container: $('.items')
      offset: 2
      item_width: 210

    console.log options


    #$('li.item').CoolGrid(options)

    return