$ ->


  $(".dropdown_toggle").click ->

    $menu = $('.dropdown_menu')
    isAnable = $(".dropdown_menu").attr('show')

    if isAnable == 'disable'
      $menu.hide().attr('show', '')
    else
      $menu.show().attr('show', 'disable')



