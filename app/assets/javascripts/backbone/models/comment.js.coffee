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
  url : '/settings/comments'

  initialize: (models, options) ->
    if options.user_id
      @url = '/users/' + options.user_id + '/comments'
    else if options.item_id
      @url = '/items/' + options.item_id + '/comments'
