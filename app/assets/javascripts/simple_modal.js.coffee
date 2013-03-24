#----------------------------------------------
# モーダル画面の表示
#----------------------------------------------
(($)->
  $.SimpleModal = (element, options) ->
    #console.log('new init------------');
    #console.log(options);
    #console.log('new init------------ end');

    defaults =
      target: ''
      continue_overlay: false
      close_callback: ->
      css_overlay:
        position: 'fixed'
        top: 0
        right: 0
        bottom: 0
        left: 0
        'z-index': 1000;
        'background-color': '#ffffff';
        opacity: 0.85;
        filter: 'progid:DXImageTransform.Microsoft.Alpha(Opacity=85)'
        filter: 'alpha(opacity=80)'
        display: 'none'
      css_window:
        opacity:            0
        position:           'fixed'
        padding:            '0px'
        margin:             '0px'
        width:              '30%'
        top:                '30%'
        left:               '35%'
        #'text-align':       'center'
        color:              'rgb(0, 0, 0)'
        #border:             '3px solid #000'
        border:             '0px'
        'background-color': '#fff'
        #cursor: 'wait'
        'z-index': 9000

    plugin = this;
    plugin.options = $.fn.extend(defaults, options)
    _this = element

    #---------------------------
    # init
    #---------------------------
    plugin.init = () ->
      # init
      options = plugin.options;
      $overlay = $('#modal_overlay')
      $modal_window = $('#modal_window')

      if $overlay.length < 1
        $('body').append($('<div id="modal_overlay"></div>').css(options.css_overlay))

      if $modal_window.length < 1
        $('body').append($('<div id="modal_window"></div>'))

      return plugin


    #---------------------------
    # close
    #---------------------------
    plugin.close = () ->
      # init
      options = plugin.options;
      callback = () ->

      if options.continue_overlay == false
        callback = () ->
          $('#modal_overlay').fadeOut(500, options.close_callback)
      else
        callback = options.close_callback

      $modal = $('#modal_window')
      $modal.animate({top: "+=100px", opacity: 0}, 500,
        () ->
          setTimeout(() ->
            callback();
          , 300);

          $modal.html('')
          $modal.remove()
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

      $modal = $('#modal_window')
      $modal.animate({top: "-=100px", opacity: 0}, 500, callback)
      return this


    #---------------------------
    # open
    #---------------------------
    plugin.open = ->
      # init
      options = plugin.options;

      #$(this).css('opacity', 0);
      #$(this).css(options.css_window);
      #console.log('start animate show')

      $clone = $(_this).clone(true)

      console.log $(window).height()
      console.log $(window).width()
      console.log $(_this).height()
      console.log $(_this).width()
      console.log _this

      window_height = $(window).height()
      window_width  = $(window).width()
      height = $(_this).height()
      width  = $(_this).width()

      retio = 1
      if width > 1000
        console.log "1000 / #{width} = " + 1000.0 / width
        retio = 1000.0 / width
        width = 1000

      console.log "retio = " + retio

      center_h = window_height * 0.5 - height * 0.5
      center_w = window_width * 0.5 - width * 0.5


      $modal = $('#modal_window')
      $modal.html($clone)
      $modal.children().show()
      $modal.css(options.css_window)
      $modal.css(
        'display': 'block'
        'top':     '-100px'
        'height':  height * retio + 'px'
        'width':  width + 'px'
      )

      if options.continue_overlay == false
        $('#modal_overlay').fadeIn(300, () ->
          #$(_this).css({'display': 'block', top: '-100px'})
          #$(_this).animate({top: "50%", opacity: 1}, 500)
          #$modal = $('#modal_window').html($(_this))).css(options.css_window).css({'display': 'block', top: '-100px'}

          $('img', $modal).css('width', width + 'px')
          #$modal.animate({top: "30%", opacity: 1}, 500)
          $modal.animate({top: center_h, left: center_w, opacity: 1}, 500)
          #console.log $modal
        )
      else
        #$(_this).css({'display': 'block', top: '-100px'})
        #$(_this).animate({top: "30%", opacity: 1}, 500)
        $modal.animate({top: center_h, left: center_w, opacity: 1}, 500)

    plugin.init()

  $.fn.SimpleModal = (options) ->
    plugin = new $.SimpleModal(this, options)
    plugin.init()
    return plugin

)(jQuery);