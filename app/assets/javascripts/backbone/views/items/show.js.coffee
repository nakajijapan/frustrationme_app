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

    # render comment list
    @collection = new BackboneFrustration.Collections.Comments([], {item_id: @$el.data('item_id')})
    @list()
    @collection.bind 'add', @_append_comment

    # form
    @form_view = new BackboneFrustration.Views.Fumans.CreateView()
    @form_view.close_callback = (product_id) =>
      $('#frustration_button').addClass('registered').fadeIn()
      @undelegateEvents()

  show_modal: (e) ->
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

    saved = comment.save(
      data,
      success : (model, res) =>
        @_append_comment(res.comment, res.comment.user)
    )

  _append_comment : (comment, user) ->
    item = new BackboneFrustration.Models.Comment(comment)
    view = new BackboneFrustration.Views.Items.Show_CommentView model: item
    $("#comments_box").prepend view.render(user).el

  list: ->
    @collection.fetch
      success: (model, response) =>
        $.each response, (key, val) =>
          @_append_comment(val, val.user)

#-----------------------------------------------------------------------------
# Index_CommentView
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Items.Show_CommentView extends Backbone.View
  template: new EJS({url: '/javascripts/backbone/views/items/comment'})
  comment: null
  tagName: 'li'

  initialize: (item) ->
    @comment = item.model

  render:(user) ->
    data =
      comment: @comment.toJSON()
      user: user

    $(@el).html(@template.render(data)).fadeIn(1000)

    @