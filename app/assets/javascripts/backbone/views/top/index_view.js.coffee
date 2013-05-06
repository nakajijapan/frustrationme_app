
BackboneFrustration.Views.Top ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Top.IndexView extends Backbone.View
  el: $("#top_index")

  initialize: () ->
    #@initialize_image()
    @initialize_grid()

    _ = @

    $.AutoPager(
      content: '.items'
      loaded: (content, next_page_num) ->
        _.initialize_grid()
      before_append: (content) ->
        $('img', $(content)).each( (i, elm) ->
          i = new Image()
          i.src = $(elm).attr('src')
          i.onerror = () ->
            console.log 'error'
        )

    )

  initialize_grid: () ->
    options =
      autoResize: true
      container: $('.items')
      offset: 2
      item_width: 210

    $('.item').CoolGrid(options)

  initialize_image: () ->
    console.log 'initialize_image'
    #console.log $('img')

    $('img').each (i, elm)->
      $elm = $(elm)

      console.log "hogehoge"
      img = new Image()
      img.src = $elm.attr('src')
      img.onload = () ->
        console.log "loaded"
        $elm.fadeIn(1000)

