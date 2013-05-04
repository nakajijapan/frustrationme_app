
BackboneFrustration.Views.Fumans ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Fumans.SearchView extends Backbone.View
  el: $("#fumans_search")
  form_view: null
  events:
    'click .service_button': 'change_search_type'
    'click .show_modal':     'show_modal'
    'keyup':                 'short_cut'

  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

    # default of api is amazon
    type = $('#s_service_name').val()
    type = 'amazon' if type == ''

    # arrow
    @_change_search_type(type)

    # form
    @form_view = new BackboneFrustration.Views.Fumans.CreateView();
    @form_view.close_callback = (product_id) ->
      $("[data-code='#{product_id}']").append('<div class="item_overlay"><div>f</div></div>')

  #------------------------
  show_modal : (e) ->
    console.log $(e.currentTarget).data('product_code')
    $('.create_fuman').attr('data-product_code', $(e.currentTarget).data('product_code'))
    @form_view.open()

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


#-----------------------------------------------------------------------------
# ModalView
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Fumans.CreateView extends Backbone.View
  el: $("#modal_create_fuman")
  events:
    'click .create_fuman' : 'create'
  services:
    'amazon': 0
    'yahooauction': 2
    'rakuten': 3
    'itunes': 4
    'frustration': 5
  close_callback: () ->

  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

  open: () ->
    $(@el).SimpleModal().open()


  #---------------------------------------
  # create
  #---------------------------------------
  create : (e) ->
    console.log "------------------------------- create"
    @_create(e)

  #-------------------
  # _create
  #-------------------
  _create: (e) ->
    name       = $('#s_service_name').val()
    product_id = $(e.currentTarget).attr('data-product_code')
    status     = $('.fuman_status.active').data('status')
    category   = $('#fuman_category option:selected').val()

    console.log "データ格納前 -------"
    console.log name
    console.log @services[name]

    return alert 'no service code'  if !name?

    _this = @

    data = {
      item : {
        service_code: @services[name]
        product_id: product_id
      }
      fuman : {
        status:      status
        category_id: category
      }
    }

    console.log data

    $.ajax(
      type : 'POST'
      url  : "/fumans/create_with_item.json"
      data : data
      success : (data, status, xhr) ->
        #$(e.srcElement).effect("highlight", {}, 1000)
        #console.log '-------success'
        #console.log data
        #console.log status
        $("#modal_create_fuman").SimpleModal({
          close_callback: ()->
            _this.close_callback(product_id)
        }).close();

      error : (xhr, status, thrown) ->
        #console.log '-------error'
        #console.log thrown
        #console.log status
        #console.log xhr
        #alert 'create error'
    )
