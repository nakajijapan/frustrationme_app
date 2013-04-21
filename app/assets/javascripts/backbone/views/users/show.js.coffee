BackboneFrustration.Views.Users ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Users.ShowView extends Backbone.View
  el: $("#users_show")
  events:
    'click #follow_button': 'create_friendship'
    'click #unfollow_button': 'destroy_friendship'

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
      $('.follow_group').html('<button class="btn" id="unfollow_button" data-id="' + model.id + '" data-following_id="' + following_id + '">unfollow</button>')

  destroy_friendship: (e) ->
    following_id = $(e.currentTarget).data('following_id')
    id           = $(e.currentTarget).data('id')

    item = new BackboneFrustration.Models.Friendship({id: id})
    item.destroy success : (model, res) =>
      $('.follow_group').html('<button class="btn" id="follow_button" data-following_id="' + following_id + '">follow</button>')
