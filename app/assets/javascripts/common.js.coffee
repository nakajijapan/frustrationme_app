$ ->
  $(".dropdown_toggle").click ->

    $menu = $('.dropdown_menu')
    isAnable = $(".dropdown_menu").attr('show')

    if isAnable == 'disable'
      $menu.hide().attr('show', '')
    else
      $menu.show().attr('show', 'disable')


window.Frustration =
  Common: {}


window.Frustration.Common = {
  show_resize_image: (elm, size) ->
    elm     = $(elm)
    data    = elm.getImageSize(size)
    width   = data.width
    height  = data.height

    target  = width
    attrName= "width"

    if width < height
      target = height
      attrName = "height"


    # 指定したサイズより大きければリサイズを行う
    if target >= size
      elm.css(attrName, size + 'px')

    elm.css('display', 'block')
    elm.parent().parent().removeClass("g_loading_icon")
    elm.fadeIn(1000)

    #console.log("laod bind end")
    return false;

}

# ローディング画像表示
#    g_loading_icon
#    g_item_image
#      を併用
#function gShowResizeImage(elm, size) {
#
#  var elm     = $(elm);
#  var data    = elm.getImageSize(size)
#  var width   = data.width;
#  var height  = data.height;
#
#  var target  = width;
#  var attrName= "width";
#  if (width < height) {
#    target = height;
#    attrName = "height";
#  }
#  // 指定したサイズより大きければリサイズを行う
#  if (target >= size) {
#    elm.css(attrName, size + 'px');
#  }
#  elm.css('display', 'block');
#  elm.parent().parent().removeClass("g_loading_icon");
#  elm.fadeIn(1000);
#
#  console.log("laod bind end");
#  return false;
#}

#function gImageLoadError(elm, size) {
#  console.log("error");
#  if (size > 120) {
#    size -= 10;
#    $(elm).attr('src', '/img/noimage_l.png')
#           .css("width", size + "px");
#  }
#  else {
#    $(elm).attr('src', '/img/noimage_m.png')
#           .css("width", size + "px");
#  }
#  elm.onabort = elm.onerror;
#}
