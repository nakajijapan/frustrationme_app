BackboneFrustration.Views ||= {}


#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.HeaderView extends Backbone.View
  el: $('header')
  events:
    'click .user_menu' : 'menu_toggle'

  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

    $('.top_menu, .user_menu').hover(
      () ->
        $('.user_menu').show();
      ,() ->
        $('.user_menu').hide();
    )

  menu_toggle: (e) ->
    $target = $(e.curentTarget)

    #display = $target.data('display');

    #if display == 0
    #  $target.show().data('display', 1);
    #else
    #  $target.hide().data('display', 0);
