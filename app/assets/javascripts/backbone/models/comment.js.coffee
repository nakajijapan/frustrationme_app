#------------------------------------------------------------
# Comment
#------------------------------------------------------------
class BackboneFrustration.Models.Comment extends BackboneFrustration.Model
  id: null
  user_id: null
  item_id: null
  text : null

  initialize: (attributes, options) ->
    @bind("invalid", @defaultErrorHandler)
    @bind("error", @defaultErrorHandler)
    @urlRoot = "/settings/comments"

  validate:(attr) ->
    if attr.text == '' or attr.text == null
      return "Please Input Comment"


class BackboneFrustration.Collections.Comments extends Backbone.Collection
  model: BackboneFrustration.Models.Comment
