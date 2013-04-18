BackboneFrustration.Views.Top ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Top.IndexView extends Backbone.View
  el: $("#top_index")

  #------------------------
  initialize: () ->
    # イベントの追加
    #@delegateEvents(@events)
    @initialize_grid()

    _ = @
    console.log "start"

    $.AutoPager(
      content: '.items'
      loaded: (next_page_num) ->
        _.initialize_grid()
    )


  loadOnScroll: () ->


  initialize_grid: () ->
    options =
      autoResize: true
      container: $('.items')
      offset: 2
      item_width: 210

    console.log options

    $('.item').CoolGrid(options)