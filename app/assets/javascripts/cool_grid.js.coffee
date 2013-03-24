
( ($) ->
  $.CoolGrid = (element, options) ->
    console.log('new init------------');
    console.log(options);
    console.log('new init------------ end');

    defaults =
      auto_resize: true
      container:   $('.items')
      offset: 2
      item_width:  210

    plugin = this;
    plugin.resize_timer = null
    plugin.options = $.fn.extend(defaults, options);

    #plugin.__bind = (fn, me) ->
    #  return () ->
    #    return fn.apply(me, arguments);


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
      console.warn "start_on_resize #{plugin.resize_timer}"
      clearTimeout(plugin.resize_timer);
      plugin.resize_timer = setTimeout(plugin._resize, 100);

    #---------------------------
    # _resize
    #---------------------------
    plugin._resize = () ->
      # init
      options = plugin.options
      columns = Math.floor(options.container.width() / options.item_width)

      #console.log "columns = #{columns} " + options.container.width()
      #console.log('start CoolGrid ----------')
      console.error 'semaiyo' + columns if columns < 1

      # gridに初期化
      items = new Array(columns)
      for v, i in items
        items[i] = []

      console.log items

      # 真ん中に配置させるための差
      width_offset = (options.container.width() - (options.item_width + options.offset) * columns) / 2
      console.log "width_offset = #{width_offset}"

      # gridの位置を確定する
      backup_row = 0
      current_column = 0
      element.each( (i, v)->
        current_row = Math.floor(i / columns)

        if current_row != backup_row
          console.log "change!!!"
          current_column = 0

        console.log " -- #{current_row} / #{current_column} --"

        backup_row = current_row

        if current_row == 0
          data =
            top:   0
            height: v.offsetHeight
            left_position: (options.item_width + options.offset) * current_column + width_offset
        else
          data =
            top:   items[current_column][current_row - 1].height + items[current_column][current_row - 1].top + options.offset * 3
            height: v.offsetHeight
            left_position: (options.item_width + options.offset) * current_column + width_offset

        #if current_column == 0
        #  data.left_position += width_offset

        # 真ん中に配置させる
        items[current_column][current_row] = data

        # DOMに反映させる
        $(v).css
          'position': 'absolute'
          'display': 'list-item'
          'top': data.top
          'left': data.left_position

        current_column++
        #console.log items
        #console.log v
        #console.log v.clientHeight
        #console.log v.offsetHeight
      )

      console.log items
      #options.container.css
      #  height:

    #--------------------------------
    plugin.init()
    plugin._resize()








  $.fn.CoolGrid = (options) ->
    plugin = new $.CoolGrid(this, options)
    plugin.init()
    return plugin

)(jQuery);