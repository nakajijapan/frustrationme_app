#------------------------------------------------------------
# Friendship
#------------------------------------------------------------
class BackboneFrustration.Models.Friendship extends BackboneFrustration.Model
  id: null
  user_id: null
  following_id: null
  urlRoot : '/friendships'

class BackboneFrustration.Collections.Friendships extends Backbone.Collection
  model: BackboneFrustration.Models.Friendship
