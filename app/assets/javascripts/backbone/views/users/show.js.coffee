BackboneFrustration.Views.Users ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Users.ShowView extends Backbone.View
  el: $("#users_show")
  #events:

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

    console.log options

    $('.item').CoolGrid(options)