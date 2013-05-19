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
    'click  .search_status'    : 'set_status'
    'click  .fuman_status'     : 'update_status'
    'change .fuman_category'   : 'update_category'
    'click  .save_button'      : 'create_comment'
    'click  .delete_comment a' : 'delete_comment'

    'click  .delete_fuman'     : 'delete_fuman'

  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

    $('li.item').hover(
      () ->
        $('.delete_fuman', @).show()
      () ->
        $('.delete_fuman', @).hide()
    )

    # 404の画像はnoimageにする
    $('img.item_image').each (i, elm) ->
      $elm  = $(elm)
      i     = new Image()
      i.src = $elm.attr('src')
      i.onload = () ->
        if $elm.getImageSize().width == undefined
          $elm.attr('src', '/assets/noimage_l.png')
      i.onerror = () ->
        $elm.attr('src', '/assets/noimage_l.png')



  set_status: (e) ->
    status = $(e.currentTarget).data('status')
    $('#search_status').val(status)

  update_status : (e) ->
    fuman = new BackboneFrustration.Models.Fuman

    data =
      id     : $(e.currentTarget).data('fuman_id')
      status : $(e.currentTarget).data('status')

    fuman.save(
      data,
      success : (model, res) ->
        $('[data-fuman_id=' + data.id  + '] .status .popup_info').fadeIn(1000).fadeOut(1000)
    )

  update_category : (e) ->
    fuman = new BackboneFrustration.Models.Fuman
    data =
      id     : $(e.currentTarget).data('fuman_id')
      category_id : $(e.currentTarget).val()

    fuman.save(
      data,
      success : (model, res) ->
        $('[data-fuman_id=' + data.id  + '] .category .popup_info').fadeIn(1000).fadeOut(1000)
    )

  create_comment : (e) ->
    item_id = $(e.currentTarget).data('item_id')
    fuman_id = $(e.currentTarget).data('fuman_id')
    comment = new BackboneFrustration.Models.Comment
    data =
      item_id: item_id
      text : $("#fuman_comment_#{item_id}").val()

    # be empty
    $("#fuman_comment_#{item_id}").val('').focus()

    saved = comment.save(
      data,
      success : (model, res) =>
        @_append_comment(res)
        $('[data-fuman_id=' + fuman_id  + '] .comment .popup_info').fadeIn(1000).fadeOut(1000)
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

  delete_fuman: (e) ->
    console.log "delete_fuman"
    if confirm '削除します。よろしいですか？'
      fuman_id = $(e.currentTarget).data('fuman_id')
      data =
        id: fuman_id
      fuman = new BackboneFrustration.Models.Fuman(data)
      fuman.destroy()

      $("li.item[data-fuman_id=#{fuman_id}]").fadeOut('slow', ()->
        @remove()
      )

#-----------------------------------------------------------------------------
# Index_CommentView
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Fumans.Index_CommentView extends Backbone.View
  template: new EJS({url: '/javascripts/backbone/views/fumans/comment'})
  comment: null

  initialize: (item) ->
     @comment = item.model

  render: ->
    data =
      comment: @comment.toJSON()

    $(@el).html(@template.render(data)).fadeIn(1000)

    @





