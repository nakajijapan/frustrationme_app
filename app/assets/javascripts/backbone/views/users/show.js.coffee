BackboneFrustration.Views.Users ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Users.ShowView extends Backbone.View
  el: $("#users_show")
  events:
    'click #follow_button': 'create_friendship'
    'click #unfollow_button': 'destroy_friendship'

    'click #item_menu_all':      'menu_toggle_all'
    'click #item_menu_status':   'menu_toggle_status'
    'click #item_menu_category': 'menu_toggle_category'
  default_grid_size: 180.0

  #------------------------
  initialize: () ->

    # イベントの追加
    @delegateEvents(@events)

    # グリッド表示
    @initialize_grid()

    # ロード時に再計算
    $(window).load () =>
      @initialize_grid()

    $.AutoPager
      content: '.items'
      offset:  800
      loaded: (content, next_page_num) =>
        @initialize_grid()
      before_append: (content) =>
        $elm = $('img.item_image', $(content))

        # 解析した画像の数
        count = $elm.length

        # prefetchして最後までいったらグリッドの計算
        $elm.each (i, elm) =>
          i = new Image()
          $elm = $(elm)
          i.src = $elm.attr('src')
          i.onload = () =>
            count--
            @initialize_grid() if count < 1
          i.onerror = () =>
            $elm.attr('src', '/assets/noimage_l.png')
            $elm.css
              width:  "#{@default_grid_size}px"
              height: "#{@default_grid_size}px"
            count--

        return content

  initialize_grid: () ->
    options =
      autoResize: true
      container: $('.items')
      offset: 5
      item_width: 210

    $('.item').CoolGrid(options)

  create_friendship: (e) ->
    item = new BackboneFrustration.Models.Friendship
    following_id = $(e.currentTarget).data('following_id')
    item.save {following_id: following_id}, success : (model, res) =>
      $('.follow_group').html('<button class="btn" id="unfollow_button" data-following_id="' + following_id + '">unfollow</button>')

  destroy_friendship: (e) ->
    following_id = $(e.currentTarget).data('following_id')

    item    = new BackboneFrustration.Models.Friendship()
    item.id = following_id
    item.destroy(success : (model, response) ->
      $('.follow_group').html('<button class="btn" id="follow_button" data-following_id="' + following_id + '">follow</button>')
    )

  menu_toggle_all: (e) ->
    $(".menu_status").hide()
    $(".menu_category").hide()

  menu_toggle_status: (e) ->
    $(".menu_status").show()
    $(".menu_category").hide()

  menu_toggle_category: (e) ->
    $(".menu_status").hide()
    $(".menu_category").show()
