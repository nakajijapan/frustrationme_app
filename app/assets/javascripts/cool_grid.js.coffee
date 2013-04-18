
( ($) ->
  $.CoolGrid = (element, options) ->
    defaults =
      auto_resize: true
      container:   $('.items')
      offset: 2
      item_width:  210

    plugin = this;
    plugin.resize_timer = null
    plugin.options = $.fn.extend(defaults, options);

    #---------------------------
    # init
    #---------------------------
    plugin.init = () ->
      # 自動リサイズを有効にするか
      if plugin.options.auto_resize
        $(window).bind('resize.CoolGrid', plugin._on_resize);

      return plugin

    #---------------------------
    # _on_resize
    #---------------------------
    plugin._on_resize = () ->
      clearTimeout(plugin.resize_timer);
      plugin.resize_timer = setTimeout(plugin._resize, 100);

    #---------------------------
    # _resize
    #---------------------------
    plugin._resize = () ->
      # init
      options = plugin.options

      # 列数を求める
      columns = Math.floor(options.container.width() / options.item_width)

      # gridに初期化
      items = new Array(columns)
      for v, i in items
        items[i] = []

      # 真ん中に配置させるための差
      width_offset = (options.container.width() - (options.item_width + options.offset) * columns) / 2

      # init
      backup_row = 0
      current_column = 0

      max_row_height  = 0
      max_item_height = 0

      # gridの位置を確定する
      element.each( (i, v)->

        # ある行の列ずつみていく
        current_row = Math.floor(i / columns)

        # 列が最大まできたら次の行へ移動
        if current_row != backup_row
          current_column = 0

        # 取得した高さを格納
        item_height = v.offsetHeight

        # グリッドごとに位置の計算をする
        backup_row = current_row
        if current_row == 0
          data =
            top:   0
            height: item_height
            left_position: (options.item_width + options.offset) * current_column + width_offset
        else
          data =
            top:   items[current_column][current_row - 1].height + items[current_column][current_row - 1].top + options.offset * 3
            height: item_height
            left_position: (options.item_width + options.offset) * current_column + width_offset

        # 真ん中に配置させる
        items[current_column][current_row] = data

        # DOMに反映させる
        $(v).css
          'position': 'absolute'
          'display': 'list-item'
          'top': data.top
          'left': data.left_position

        if data.top > max_row_height
          max_row_height = data.top

        if $(v).height() > max_item_height
          max_item_height = $(v).height()

        current_column++
      )

      options.container.css('height', "#{max_row_height + max_item_height}px")
      console.log max_row_height

    #---------------------------
    # main
    #---------------------------
    plugin.init()
    plugin._resize()


  $.fn.CoolGrid = (options) ->
    plugin = new $.CoolGrid(this, options)
    plugin.init()
    return plugin

)(jQuery);