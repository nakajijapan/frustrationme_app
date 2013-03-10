
BackboneFrustration.Views.Fumans ||= {}

#-----------------------------------------------------------------------------
# SettingsMobileFilterView
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Fumans.SearchView extends Backbone.View

  el: $("#fumans_search")
  events:
    'click .service_button'      : 'change_search_type'
    'click .actions .create' : 'create'
    'keyup': 'short_cut'
  services:
    'amazon': 0
    'yahooauction': 2
    'rakuten': 3
    'itunes': 4
    'frustration': 5

  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

    # default of api is amazon
    type = $('#s_service_name').val()
    type = 'amazon' if type == ''

    # arrow
    @_change_search_type(type)

  #------------------------
  create : (e) ->
    console.log e.currentTarget

    name       = $('s_service_name').val()
    product_id = $(e.currentTarget).attr('data-product_id')

    data = {
      item : {
        service_code: @services['amazon']
        product_id: 'B000J4P83G'
      }
      fuman : {
        status:      '1'
        category_id: '1'
        content:     'hogehoge'
      }
    }

    console.log data

    $.ajax(
      type : 'POST'
      url  : "/fumans/create_with_item.json"
      data : data
      success : (data, status, xhr) ->
        #$(e.srcElement).effect("highlight", {}, 1000)
        console.log data
        console.log status
      error : (xhr, status, thrown) ->
        console.log thrown
        console.log status
        #alert 'create error'
    )

  #------------------------
  change_search_type : (e) ->
    target = $(e.currentTarget)

    @_change_search_type(target.attr('data-service_name'))

  _change_search_type : (type) ->
    console.error "no type" if type == ''

    $.get("/fumans/categories/#{type}", null, (data, status) ->

      # add hidden
      $('#s_service_name').val(type)

      # add options
      $('.service_categories').html(data)

      # arrow
      $('.service_button').each( (i, elm) ->
        $(elm).removeClass('forcus')
        $(elm).addClass('forcus') if $(elm).attr('data-service_name') == type
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