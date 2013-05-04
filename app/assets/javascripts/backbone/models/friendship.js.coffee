#------------------------------------------------------------
# Friendship
#------------------------------------------------------------
class BackboneFrustration.Models.Friendship extends BackboneFrustration.Model
  id: null
  user_id: null
  following_id: null
  urlRoot : '/friendships'

  delete: (following_id, callbacks) ->
    $.ajax(
      url: '/friendships/delete.json'
      type: 'DELETE'
      data:
        following_id: following_id
      success: callbacks.success
    )

class BackboneFrustration.Collections.Friendships extends Backbone.Collection
  model: BackboneFrustration.Models.Friendship
