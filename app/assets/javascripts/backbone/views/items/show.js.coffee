BackboneFrustration.Views.Items ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Items.ShowView extends Backbone.View
  el: $("#items_show")
  form_view: null
  events:
    'click .button_group .frustrate'  : 'show_modal'

  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

    # 登録されていればイベントは無くす
    @undelegateEvents() if $('#frustration_button').hasClass('registered')

    _this = @

    # form
    @form_view = new BackboneFrustration.Views.Fumans.CreateView();
    @form_view.close_callback = (product_id) ->
      $('#frustration_button').addClass('registered').fadeIn();
      _this.undelegateEvents()

  show_modal: (e) ->
    console.log $(e.currentTarget).data('product_code')
    $('.create_fuman').attr('data-product_code', $(e.currentTarget).data('product_code'))
    @form_view.open()