
BackboneFrustration.Views.Fumans ||= {}

#-----------------------------------------------------------------------------
# SettingsMobileFilterView
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Fumans.SearchView extends Backbone.View

  el: $("#fumans_search")
  events:
    'click .service_button'      : 'change_search_type'

  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

    # arrow
    @_change_search_type($('#s_type').val())

  #------------------------
  change_search_type : (e) ->
    target = $(e.currentTarget)

    @_change_search_type(target.attr('data'))

  _change_search_type : (type) ->
    $.get("/fumans/categories/#{type}", null, (data, status) ->
      # add options
      $('.service_categories').html(data)

      # arrow
      $('.service_button').each( (i, elm) ->
        $(elm).removeClass('forcus')
        $(elm).addClass('forcus') if $(elm).attr('data') == type
      )
    )

  #------------------------
  # ボックスの表示制御
  #toggle_box: () ->
  #  elm = $("input[name='diary[filter_use]']:checked")
  #  if elm.val() == undefined
  #    $('.filter_setting').css('opacity', 0.3);
  #  else
  #    $('.filter_setting').css('opacity', 1);