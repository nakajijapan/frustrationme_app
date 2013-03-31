#------------------------------------------------------------
# Category
#------------------------------------------------------------
class BackboneFrustration.Models.Category extends BackboneFrustration.Model
  id: null
  user_id: null
  name : ''

  initialize: (attributes, options) ->
    @bind('invalid', @defaultErrorHandler)
    @bind('error', @defaultErrorHandler)
    @urlRoot = "/settings/categories"

  validate:(attr) ->
    if attr.name == '' or attr.name == null
      return 'Please Input Category'


class BackboneFrustration.Collections.Categories extends BackboneFrustration.Collection
  model: BackboneFrustration.Models.Category
  url : '/settings/categories'

