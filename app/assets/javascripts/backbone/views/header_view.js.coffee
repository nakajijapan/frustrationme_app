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


