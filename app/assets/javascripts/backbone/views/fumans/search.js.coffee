
BackboneFrustration.Views.Fumans ||= {}

#-----------------------------------------------------------------------------
# SettingsMobileFilterView
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Fumans.SearchView extends Backbone.View

  el: $("#fumans_search")
  events:
    'click .service_button'      : 'change_search_type'
    'keyup': 'short_cut'

  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

    # default of api is amazon
    type = $('#s_type').val()
    type = 'amazon' if type == ''

    # arrow
    @_change_search_type(type)

  #------------------------
  change_search_type : (e) ->
    target = $(e.currentTarget)

    @_change_search_type(target.attr('data-type'))

  _change_search_type : (type) ->
    console.error "no type" if type == ''

    $.get("/fumans/categories/#{type}", null, (data, status) ->

      # add hidden
      $('#s_type').val(type)

      # add options
      $('.service_categories').html(data)

      # arrow
      $('.service_button').each( (i, elm) ->
        $(elm).removeClass('forcus')
        $(elm).addClass('forcus') if $(elm).attr('data-type') == type
      )
    )

  #------------------------
  # キーでサービスを切り替えるようにする
  short_cut: (e)->
    # a:65 y:89 r82 i:73 f:70 Ctrl:17

  #------------------------
  # ボックスの表示制御
  #toggle_box: () ->
  #  elm = $("input[name='diary[filter_use]']:checked")
  #  if elm.val() == undefined
  #    $('.filter_setting').css('opacity', 0.3);
  #  else
  #    $('.filter_setting').css('opacity', 1);