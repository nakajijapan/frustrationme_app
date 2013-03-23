#----------------------------------------------
# モーダル画面の表示
#----------------------------------------------
(($)->
  $.SimpleModal = (element, options) ->
      #console.log('new init------------');
      #console.log(options);
      #console.log('new init------------ end');

      defaults =
        target: '',
        continue_overlay: false,
        close_callback: ->

      plugin = this;

      console.log 'start simplemodal ----------'
      console.log options
      plugin.options = $.fn.extend(defaults, options)


      #---------------------------
      # init
      #---------------------------
      plugin.init = () ->
        _this = element
        return plugin

      #---------------------------
      # close
      #---------------------------
      plugin.close = () ->
        # init
        options = plugin.options;

        console.log("close-------------");
        callback = () ->
        if options.continue_overlay == false
          callback = () ->
            $('#modal_overlay').fadeOut(1000, options.close_callback)
        else
          callback = options.close_callback

        console.log options.close_callback
        console.log 'start animate'

        $(_this).animate({top: "+=300px", opacity: 0}, 500,
          () ->
            setTimeout(() ->
              callback();
            , 1000);
        )
        .animate({top: "-1000px"}, 0);

        return this


      #---------------------------
      # cancel
      #---------------------------
      plugin.cancel = () ->
        # init
        options = plugin.options;

        callback = () ->
          $('#modal_overlay').fadeOut(1000, options.close_callback)

        $(_this).animate({top: "-=300px", opacity: 0}, 500, callback).animate({top: "-1000px"}, 0);
        return this


      #---------------------------
      # open
      #---------------------------
      plugin.open = ->
        # init
        options = plugin.options;

        $(this).css('opacity', 0);

        console.log('start animate show')

        if options.continue_overlay == false
          $('#modal_overlay').fadeIn(300, () ->
            $(_this).css({'display': 'block', top: '-100px'})
            $(_this).animate({top: "50%", opacity: 1}, 500)
          )
        else
          $(_this).css({'display': 'block', top: '-100px'})
          $(_this).animate({top: "50%", opacity: 1}, 500)

      plugin.init()

  $.fn.SimpleModal = (options) ->
    plugin = new $.SimpleModal(this, options)
    plugin.init()
    return plugin

)(jQuery);