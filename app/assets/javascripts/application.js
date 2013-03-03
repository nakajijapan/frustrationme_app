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

