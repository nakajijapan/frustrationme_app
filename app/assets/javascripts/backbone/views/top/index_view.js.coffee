BackboneFrustration.Views.Top ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Top.IndexView extends Backbone.View
  el: $("#top_index")
  default_grid_size: 180.0

  initialize: () ->

    # グリッド描画
    @initialize_grid()

    _ = @

    # ロード時に再計算
    $(window).load () ->
      _.initialize_grid()

    $.AutoPager(
      content: '.items'
      loaded: (content, next_page_num) ->
        _.initialize_grid()
      before_append: (content) ->
        $('img', $(content)).each( (i, elm) ->
          i = new Image()
          i.src = $(elm).attr('src')
          i.onerror = () ->
            $elm.attr('src', '/assets/noimage_l.png')
            $elm.css
              width:  "#{_.default_grid_size}px"
              height: "#{_.default_grid_size}px"
        )
    )

  initialize_grid: () ->
    options =
      autoResize: true
      container: $('.items')
      offset: 2
      item_width: 210

    $('.item').CoolGrid(options)
