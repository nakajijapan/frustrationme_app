BackboneFrustration.Views.Top ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Top.IndexView extends Backbone.View
  el: $("#top_index")

  #------------------------
  initialize: () ->
    @initialize_grid()

    _ = @

    $.AutoPager(
      content: '.items'
      loaded: (next_page_num) ->
        _.initialize_grid()
    )

  initialize_grid: () ->
    options =
      autoResize: true
      container: $('.items')
      offset: 2
      item_width: 210

    $('.item').CoolGrid(options)