BackboneFrustration.Views.Fumans ||= {}


#$.event.add(window, "load", () ->
#  console.log 'onload'
#  $('li.item').CoolGrid()
#)

#Backbone.sync = (method, model) ->
#  alert(method + ": " + JSON.stringify(model))

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Fumans.IndexView extends Backbone.View
  el: $('#fumans_index')
  events:
    'click  .fuman_status'     : 'update_status'
    'change .fuman_category'   : 'update_category'
    'click  .save_button'      : 'create_comment'
    'click  .delete_comment a' : 'delete_comment'

  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

  #auto_height: () ->
  #  options  =
  #    auto_resize: true
  #    container: $('.items')
  #    offset: 2
  #    item_width: 210
  #  $('li.item').CoolGrid(options)
  #  return

  update_status : (e) ->
    fuman = new BackboneFrustration.Models.Fuman
    data =
      id     : $(e.currentTarget).data('fuman_id')
      status : $(e.currentTarget).data('status')

    fuman.save(
      data,
      success : (model, res) ->
    )

  update_category : (e) ->
    fuman = new BackboneFrustration.Models.Fuman
    data =
      id     : $(e.currentTarget).data('fuman_id')
      category_id : $(e.currentTarget).val()

    fuman.save(
      data,
      success : (model, res) ->
    )

  create_comment : (e) ->
    item_id = $(e.currentTarget).data('item_id')
    comment = new BackboneFrustration.Models.Comment
    data =
      item_id: item_id
      text : $("#fuman_comment_#{item_id}").val()

    # be empty
    $("#fuman_comment_#{item_id}").val('').focus()

    _this = @

    saved = comment.save(
      data,
      success : (model, res) ->
        _this._append_comment(res)
    )

  _append_comment : (comment) ->
    view = new BackboneFrustration.Views.Fumans.Index_CommentView model: comment
    $("ul[data-item_id=#{comment.item_id}]").prepend view.render().el


  delete_comment : (e) ->
    comment_id = $(e.currentTarget).data('comment_id')

    data =
      id: comment_id
    comment = new BackboneFrustration.Models.Comment(data)
    comment.destroy()

    $("li[data-comment_id=#{comment_id}]").fadeOut('slow',
      () ->
        $(this).remove()
    )


#-----------------------------------------------------------------------------
# Index_CommentView
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Fumans.Index_CommentView extends Backbone.View
  template: new EJS({url: '/javascripts/backbone/views/fumans/comment'})
  comment: null
  #events:
  #  'click .delete_comment a' : 'delete_comment'

  initialize: (item) ->
     #_.bindAll @

     @comment = item

  render: ->
    data =
      comment: @comment.model

    $(@el).html(@template.render(data)).fadeIn('slow')

    @





