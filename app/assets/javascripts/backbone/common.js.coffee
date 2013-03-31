# backbone namespace
window.BackboneFrustration =
  Collections: {}
  Models: {}
  Routers: {}
  Views: {}
  Config: {}

#-------------------------------------------
# Model
#-------------------------------------------
class BackboneFrustration.Model extends Backbone.Model
  # ui: Utils.UI
  initialize: (attributes, options) ->
    @.bind('error', @.defaultErrorHandler)
    @.bind('invalid', @.defaultErrorHandler)

  defaultErrorHandler: (model, error) ->
    if typeof(error) == 'object'
      if error.statusText != ''
        alert 'Intal Server Error'
        console.error error

     else if typeof(error) == 'string'
       if error? or error != ''
         alert(error);


class BackboneFrustration.Collection extends Backbone.Collection
