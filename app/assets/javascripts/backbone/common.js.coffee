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
    @on 'error',   @defaultErrorHandler
    @on 'invalid', @defaultErrorHandler

  defaultErrorHandler: (model, error) ->
    if typeof(error) == 'object'
      if error.statusText != ''
        alert 'Intal Server Error'
        console.error error

     else if typeof(error) == 'string'
       if error? or error != ''
         alert(error);

  # POST, PUT
  toJSON: () ->
    return _(_.clone(@attributes)).extend
      authenticity_token: BackboneFrustration.Model.csrf_token()

BackboneFrustration.Model.csrf_token = () ->
  $('meta[name="csrf-token"]').attr('content')

class BackboneFrustration.Collection extends Backbone.Collection
