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

  #------------------------
  initialize: () ->

    # イベントの追加
    @delegateEvents(@events)

    # グリッド表示
    @initialize_grid()

    _ = @

    $.AutoPager(
      content: '.items'
      loaded: (next_page_num) ->
        _.initialize_grid()
    )

  initialize_grid: () ->
    options =
      autoResize: true
      container: $('.items')
      offset: 2
      item_width: 210

    $('.item').CoolGrid(options)

  create_friendship: (e) ->
    item = new BackboneFrustration.Models.Friendship
    following_id = $(e.currentTarget).data('following_id')
    item.save {following_id: following_id}, success : (model, res) =>
      console.log model
      $('.follow_group').html('<button class="btn" id="unfollow_button" data-following_id="' + following_id + '">unfollow</button>')

  destroy_friendship: (e) ->
    following_id = $(e.currentTarget).data('following_id')

    item = new BackboneFrustration.Models.Friendship()
    item.delete(following_id, success : (result) ->
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
