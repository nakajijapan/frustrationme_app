// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery.min
//= require jquery-ui.min
//= require jquery_ujs
//= require jquery/jquery.wookmark
//= require bootstrap

//----------------------------------------------
// サイズ取得
//----------------------------------------------
jQuery.fn.extend({
  getImageSize : function(size) {
    var image = new Image();
    var nWidth  = 0;
    var nHeight = 0;

    image.src = this.attr('src');

    // ブラウザによってプロパティを変更する
    if ( typeof  image.naturalWidth !== 'undefined' ) {  // for Firefox, Safari, Chrome
      nWidth  = image.naturalWidth;
      nHeight = image.naturalHeight;
    }
    else if ( typeof image.runtimeStyle !== 'undefined' ) { // for IE
      var run = image.runtimeStyle;
      var mem = {w: run.width, h: run.height};  // keep runtimeStyle
      run.width  = "auto";
      run.height = "auto";
      nWidth  = image.width;
      nHeight = image.height;
      run.width = mem.w;
      run.height= mem.h;
    }

    // 画像が取得できない場合は、noimage用の画像と入れ替える。
    if (nWidth < 2 && nHeight < 2) {
      if (size > 120) {
        this.attr('src', '/img/noimage_l.png');
      }
      else {
        this.attr('src', '/img/noimage_m.png');
      }
      return {width: size, height: size};
    }

    return {width: nWidth, height: nHeight};
  }
});

//----------------------------------------------
// モーダル画面の表示
//----------------------------------------------
(function($) {
  $.SimpleModal = function(element, options) {
      //console.log('new init------------');
      //console.log(options);
      //console.log('new init------------ end');

      var defaults = {
        target: '',
        continue_overlay: false,
        close_callback: function() {}
      }
      var plugin = this;

      console.log('start simplemodal ----------');
      console.log(options);
      plugin.options = $.fn.extend(defaults, options);
      console.log(plugin.options);
      //---------------------------
      // init
      //---------------------------
      plugin.init = function() {
        _this = element;
        return plugin;
      }

      //---------------------------
      // close
      //---------------------------
      plugin.close = function() {
        // init
        options = plugin.options;

        console.log("close-------------");
        var callback = function(){};
        if(options.continue_overlay == false) {
          callback = function(){
            $('#modal_overlay').fadeOut(1000, options.close_callback);
          }
        }
        else {
          callback = options.close_callback;
        }

        console.log(options.close_callback);
        //console.log('start animate');
        //console.log(_this);
        //console.log(this);

        $(_this).animate({top: "+=300px", opacity: 0}, 500,
          function(){
            setTimeout(function(){
              callback();
            }, 1000);
          }
        )
        .animate({top: "-1000px"}, 0);
        //console.log('delay');
        //$(this).animate({top: "+=300px", opacity: 0}, 500).animate({}, 2000, callback);

        return this;
      }

      //---------------------------
      // cancel
      //---------------------------
      plugin.cancel = function() {
        // init
        options = plugin.options;

        var callback = function(){
          $('#modal_overlay').fadeOut(1000, options.close_callback);
        }

        $(_this).animate({top: "-=300px", opacity: 0}, 500, callback).animate({top: "-1000px"}, 0);
        console.log('delay');

        return this;
      }

      //---------------------------
      // open
      //---------------------------
      plugin.open = function() {
        // init
        options = plugin.options;

        $(this).css('opacity', 0);
        //console.log("open-----------");
        //console.log(this);
        //console.log(_this);

        //console.log('start animate show')
        if(options.continue_overlay == false) {
          $('#modal_overlay').fadeIn(300, function(){
            $(_this).css({'display': 'block', top: '-100px'});
            $(_this).animate({top: "50%", opacity: 1}, 500);
          });
        }
        else {
          $(_this).css({'display': 'block', top: '-100px'});
          $(_this).animate({top: "50%", opacity: 1}, 500);
        }
      }

      plugin.init();
  }

  $.fn.SimpleModal = function(options) {
    var plugin = new $.SimpleModal(this, options);
    plugin.init();
    return plugin;
  }
})(jQuery);