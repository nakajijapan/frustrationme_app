BackboneFrustration.Views.Friendships ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Friendships.FollowingsView extends Backbone.View
  el: $("#friendships_followings")
  events:
    'click #follow_button': 'create_friendship'
    'click #unfollow_button': 'destroy_friendship'

  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

  create_friendship: (e) ->
    item = new BackboneFrustration.Models.Friendship
    following_id = $(e.currentTarget).data('following_id')
    item.save {following_id: following_id}, success : (model, res) =>
      console.log model
      $('.follow_group[data-following_id=' + following_id + ']').html('<button class="btn" id="unfollow_button" data-following_id="' + following_id + '">unfollow</button>')

  destroy_friendship: (e) ->
    following_id = $(e.currentTarget).data('following_id')

    item = new BackboneFrustration.Models.Friendship()
    item.delete(following_id, success : (result) ->
      $('.follow_group[data-following_id=' + following_id + ']').html('<button class="btn" id="follow_button" data-following_id="' + following_id + '">follow</button>')
    )

class BackboneFrustration.Views.Friendships.FollowersView extends BackboneFrustration.Views.Friendships.FollowingsView
  el: $("#friendships_followers")