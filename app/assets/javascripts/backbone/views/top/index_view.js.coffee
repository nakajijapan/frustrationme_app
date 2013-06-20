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

    # ロード時に再計算
    $(window).load () =>
      @initialize_grid()

    $.AutoPager
      content: '.items'
      offset:  800
      loaded: (content, next_page_num) =>
        @initialize_grid()
      before_append: (content) =>
        $elm = $('img.item_image', $(content))

        # 解析した画像の数
        count = $elm.length

        # prefetchして最後までいったらグリッドの計算
        $elm.each (i, elm) =>
          i        = new Image()
          i.src    = $(elm).attr('src')
          i.onload = () =>
            count--
            @initialize_grid() if count < 1
          i.onerror = () =>
            $elm.attr('src', '/assets/noimage_l.png')
            $elm.css
              width:  "#{@default_grid_size}px"
              height: "#{@default_grid_size}px"
            count--

        return content

  initialize_grid: () ->
    options =
      autoResize: true
      container: $('.items')
      offset: 5
      item_width: 210

    $('.item').CoolGrid(options)

