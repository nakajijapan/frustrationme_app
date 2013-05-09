
BackboneFrustration.Views.Fumans ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Fumans.SearchView extends Backbone.View
  el: $("#fumans_search")
  form_view: null
  events:
    'click .service_button': 'change_search_type'
    'click #search_button' : 'search_items'
    'click .show_modal':     'show_modal'
    'keyup':                 'short_cut'

  #------------------------
  # init
  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

    # default of api is amazon
    type = $('#s_service_name').val()
    type = 'amazon' if type == ''

    # arrow(->)
    @_change_search_type(type)

    # form
    @form_view = new BackboneFrustration.Views.Fumans.CreateView();
    @form_view.close_callback = (product_id) ->
      $("[data-code='#{product_id}']").append('<div class="item_overlay"><div>f</div></div>')

  #------------------------
  # モーダル画面の表示
  #------------------------
  show_modal : (e) ->
    $('.create_fuman').attr('data-product_code', $(e.currentTarget).data('product_code'))
    @form_view.open()

  #------------------------
  # 検索サービスのfocusの変更
  #------------------------
  change_search_type : (e) ->
    target = $(e.currentTarget)
    @_change_search_type(target.attr('data-service_name'))

  #------------------------
  # _change_search_type
  #------------------------
  _change_search_type : (type) ->
    console.error "no type" if type == ''

    # frustrationは通常のサービスとは別処理
    if type == 'frustration'
      $('.service_categories').hide()
      $('#s_keywords').hide()
      $('#s_url').show()
      $('#s_service_name').val('frustration')
    else
      $('.service_categories').show()
      $('#s_keywords').show()
      $('#s_url').hide()

      $.get("/fumans/categories/#{type}", null, (data, status) ->

        # add hidden
        $('#s_service_name').val(type)

        # add options
        $('.service_categories').html(data)
      )

    # arrow
    $('.service_button').each( (i, elm) ->
      $(elm).removeClass('forcus')
      $(elm).addClass('forcus') if $(elm).attr('data-service_name') == type
    )

  #------------------------
  # search_items
  #------------------------
  search_items: (e) ->
    type = $('#s_service_name').val()
    if type == 'frustration'
      @_search_items_frustration()
    else
      search_form.submit()

  #------------------------
  # frustration用検索
  #------------------------
  _search_items_frustration: () ->
    url = $('#s_url').val()

    _ = @

    $.ajax
      url: url
      type: 'GET'
      beforeSend: (data) ->
        $('.items').html('<b>loading....</b>')

      success: (data) ->
        title  = _._get_title(data.responseText)
        images = _._get_images(data.responseText, url)

        $items = $('.items')
        if images.length > 0
          $items.html('')

          for image_url, i in images
            img = new Image()
            img.src = image_url
            img.onload = () ->

              if @naturalHeight < 200 and @naturalWidth < 200
                return

              _._show_item(i, url, title, @src)
        else
          $items.html('<b>not found (ToT)</b>')

  #------------------------
  # 取得したアイテムを画面に描画
  #------------------------
  _show_item: (i, url, title, image_url) ->
    params =
      detail_url: url
      title: title
      image: image_url
      index: i

    view = new BackboneFrustration.Views.Fumans.Search_ItemView params: params
    $('.items').append view.render().el

  #------------------------
  # タイトル取得
  #------------------------
  _get_title: (string) ->
    return /<title>(.*)<\/title>/.exec(string)[1]

  #------------------------
  # 画像URLの一覧を取得（サイズ関係なく）
  #------------------------
  _get_images: (string, url) ->
    image_urls = new Array()
    $(string).find('img').each (i, v) ->

      src = $(v).attr('src')

      if src.match(/^\//) == null and src.match(/^https?:/) == null
        src     = url + src

      image_urls.push src

    return image_urls


  #------------------------
  # キーでサービスを切り替えるようにする
  #------------------------
  short_cut: (e) ->
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
# Search_ItemView
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Fumans.Search_ItemView extends Backbone.View
  template: new EJS({url: '/javascripts/backbone/views/fumans/item_frustration'})
  item: null
  events:
    'click .show_modal_frustration':     'show_modal'

  #------------------------
  # init
  #------------------------
  initialize: (options) ->
    @item = options.params

    # イベントの追加
    @delegateEvents(@events)

  #------------------------
  # render
  #------------------------
  render: ->
    data =
      item: @item

    $(@el).html(@template.render(data)).delay(1000 * @item.index).fadeIn(1000)

    @

  #------------------------
  # show_modal
  #------------------------
  show_modal : (e) ->

    _ = @

    # form
    form_view = new BackboneFrustration.Views.Fumans.CreateFrustrationView()
    form_view.item = @item
    form_view.close_callback = () ->
      $('.item_box', $(_.el)).append('<div class="item_overlay"><div>f</div></div>')
    form_view.open()

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
  # init
  #------------------------
  initialize: (options) ->
    # イベントの追加
    @delegateEvents(@events)

  #------------------------
  # open
  #------------------------
  open: () ->
    $(@el).SimpleModal().open()


  #---------------------------------------
  # create
  #---------------------------------------
  create : (e) ->
    @_create(e)

  #-------------------
  # _create
  #-------------------
  _create: (e) ->
    name       = $('#s_service_name').val()
    product_id = $(e.currentTarget).attr('data-product_code')
    status     = $('.fuman_status.active').data('status')
    category   = $('#fuman_category option:selected').val()

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

    $.ajax(
      type : 'POST'
      url  : "/fumans/create_with_item.json"
      data : data
      success : (data, status, xhr) ->
        $("#modal_create_fuman").SimpleModal({
          close_callback: ()->
            _this.close_callback(product_id)
        }).close();
    )

#-----------------------------------------------------------------------------
# ModalView
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Fumans.CreateFrustrationView extends BackboneFrustration.Views.Fumans.CreateView
  el: $("#modal_create_fuman_frustration")
  item: null

  #-------------------
  # _create
  #-------------------
  _create: (e) ->
    _ = @

    data = {
      item : {
        service_code: 5
        title:        @item.title
        url:          @item.detail_url
        image_l:      @item.image
      }
      fuman : {
        status:      $('.fuman_status.active').data('status')
        category_id: $('#fuman_category option:selected').val()
      }
    }

    $.ajax(
      type : 'POST'
      url  : "/fumans/create_with_item.json"
      data : data
      success : (data, status, xhr) ->
        $("#modal_create_fuman").SimpleModal({
          close_callback: ()->
            _.close_callback()
        }).close();
      error : (xhr, status, thrown) ->

    )


