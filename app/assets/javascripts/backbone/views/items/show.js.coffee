BackboneFrustration.Views.Items ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Items.ShowView extends Backbone.View
  el: $("#items_show")
  form_view: null
  events:
    'click .button_group .frustrate'  : 'show_modal'
    'click #create_comment'  : 'create_comment'

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

  create_comment: (e) ->
    item_id = $(e.currentTarget).data('item_id')
    comment = new BackboneFrustration.Models.Comment
    data =
      item_id: item_id
      text : $("#fuman_comment").val()

    # be empty
    $("#fuman_comment").val('').focus()

    _this = @

    saved = comment.save(
      data,
      success : (model, res) ->
        _this._append_comment(res)
    )

  _append_comment : (comment) ->
    view = new BackboneFrustration.Views.Items.Show_CommentView model: comment
    $(".comments ul").prepend view.render().el

#-----------------------------------------------------------------------------
# Index_CommentView
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Items.Show_CommentView extends Backbone.View
  template: new EJS({url: '/javascripts/backbone/views/items/comment'})
  comment: null
  tagName: 'li'

  initialize: (item) ->
     @comment = item

  render: ->
    data =
      comment: @comment.model
      user:
        username: $("#user_username").val()
        icon_name: $("#icon_name").val()

    $(@el).html(@template.render(data)).fadeIn('slow').removeAttr('style')

    @