#----------------------------------------------
# モーダル画面の表示
#----------------------------------------------
(($)->
  $.SimpleModal = (element, options) ->
    defaults =
      target: ''
      continue_overlay: false
      close_callback: ->
      css_overlay:
        position:           'fixed'
        top:                0
        right:              0
        bottom:             0
        left:               0
        'z-index':          1000
        'background-color': '#000000'
        opacity:            0.85
        filter:             'alpha(opacity=80)'
        display:            'none'
        cursor:             'wait'
      css_window:
        opacity:            0
        position:           'fixed'
        padding:            '0px'
        margin:             '0px'
        top:                '0px'
        color:              'rgb(0, 0, 0)'
        border:             '0px'
        'background-color': '#fff'
        'z-index':          9000

    plugin = this;

    # init
    options = {} if options == undefined

    # window's style sheet
    options.css_window  = $.fn.extend(defaults.css_window, options.css_window) if options.css_window

    # overlay's style sheet
    options.css_overlay = $.fn.extend(defaults.css_overlay, options.css_overlay) if options.css_overlay

    plugin.options = $.fn.extend(defaults, options)
    _this = element

    # browser window size
    window_height = $(window).height()
    window_width  = $(window).width()

    #---------------------------
    # init
    #---------------------------
    plugin.init = () ->
      # init
      options = plugin.options;
      $overlay = $('#modal_overlay')
      $modal_window = $('#modal_window')

      if $overlay.length < 1
        $('body').prepend($('<div id="modal_overlay"></div>').css(options.css_overlay))

      $overlay.show()

      return plugin

    #---------------------------
    # instance
    #---------------------------
    plugin.instance = () ->
      return $('#modal_window')

    #---------------------------
    # close
    #---------------------------
    plugin.close = () ->
      # init
      options = plugin.options;
      callback = () ->

      if options.continue_overlay == false
        callback = () ->
          $('#modal_overlay').fadeOut(200, options.close_callback)
      else
        callback = options.close_callback

      $modal = $(_this)
      $modal.animate({top: "+=300px", opacity: 0}, 200)
            .animate({top: "+=#{window_height}px"}, 10,
        () ->
          setTimeout(() ->
            callback()
          , 300)
      )
      return this

    #---------------------------
    # cancel
    #---------------------------
    plugin.cancel = () ->
      # init
      options = plugin.options;
      callback = () ->
        $('#modal_overlay').fadeOut(1000, options.close_callback)

      $modal = $(_this)
      $modal.animate({top: "-300px", opacity: 0}, 200)
            .animate({top: "-1000px"}, 0, callback)
      return this

    #---------------------------
    # open
    #---------------------------
    plugin.open = () ->
      # init
      options = plugin.options;

      # modal window size
      height = $(_this).height()
      width  = $(_this).width()

      # resize if modal window size is biggger than window size
      if width > window_width
        retio = window_width * 0.9 / width
        width = window_width * 0.9
        height = height * retio

      # calcurate modal window position
      center_h = window_height * 0.5 - height * 0.5
      center_w = window_width * 0.5 - width * 0.5

      # configure position
      $modal = $(_this)
      $modal.show()
      $modal.css(options.css_window)
      $modal.css(
        'display': 'block'
        'top':     '-100px'
        'left':    center_w
        'height':  height + 'px'
        'width':   width + 'px'
      )

      if options.continue_overlay == false
        $('#modal_overlay').fadeIn(300, () ->
          $('img', $modal).css('width', width + 'px')
          $modal.animate({top: center_h, left: center_w, opacity: 1}, 200)
        )
      else
        $modal.animate({top: center_h, left: center_w, opacity: 1}, 200)

    plugin.init()

  $.fn.SimpleModal = (options) ->
    plugin = new $.SimpleModal(this, options)
    plugin.init()
    return plugin

)(jQuery);