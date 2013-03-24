#------------------------------------------------------------
# Fuman
#------------------------------------------------------------
class BackboneFrustration.Models.Fuman extends BackboneFrustration.Model
  id: null
  stauts : null
  category_id: null

  initialize: (attributes, options) ->
    @bind("invalid", @defaultErrorHandler)
    @bind("error", @defaultErrorHandler)
    @urlRoot = "/fumans"


class BackboneFrustration.Collections.CategoryStore extends Backbone.Collection
  model: BackboneFrustration.Models.Fuman
