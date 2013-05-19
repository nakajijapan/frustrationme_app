BackboneFrustration.Views.Categories ||= {}

#-----------------------------------------------------------------------------
# View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Categories.IndexView extends Backbone.View
  el: $('#categories_index')
  events:
    'click .category_create': 'create'

  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

    # render category list
    @collection = new BackboneFrustration.Collections.Categories
    @list()
    @collection.bind 'add', @append_item

  create: (e)->
    category_name = $('#category_name').val()
    $('#category_name').val ''

    item = new BackboneFrustration.Models.Category

    if item.set(name: category_name)
      _this = @

      item.save null, success : (model, res) =>
        @collection.add model

    $('#category_name').focus()

  list: ->
    @collection.fetch
      success: (model, response) =>
        $.each response, (key, val) =>

          item = new BackboneFrustration.Models.Category({ id: val.id, name: val.name })
          item_view = new BackboneFrustration.Views.Categories.CategoryView model: item
          $('#items').append item_view.render().el


  append_item : (item) ->
    item_view = new BackboneFrustration.Views.Categories.CategoryView model: item
    $('#items').append item_view.render().el

#-----------------------------------------------------------------------------
# Category View
#-----------------------------------------------------------------------------
class BackboneFrustration.Views.Categories.CategoryView extends Backbone.View
  template: new EJS({url: '/javascripts/backbone/views/categories/new'})
  events:
    'click .category_update': 'update'
    'click .category_delete': 'delete'
    'click .category_cancel': 'toggle_mode_change'
    'click .category_name':  'toggle_mode_change'

  #------------------------
  initialize: () ->
    # イベントの追加
    @delegateEvents(@events)

  toggle_mode_change: (e)->
    id        = $(e.currentTarget).data('id')
    class_name = e.currentTarget.className
    @_toggle_mode_change(id, class_name)

  _toggle_mode_change: (id, class_name)->
    if class_name == 'category_name'
      $(".mode_show[data-id=#{id}]").hide();
      $(".mode_edit[data-id=#{id}]").show();
    else
      $(".mode_show[data-id=#{id}]").show();
      $(".mode_edit[data-id=#{id}]").hide();

  update: (e) ->
    pre_name = @model.previous('name')
    name = $('input[name="name"]', @el).val()

    @model.set('name', name)
    if pre_name != name
      @model.save()
      $('.mode_show .category_name', @el).html(@model.escape('name'));
      $(@el).effect("highlight", {}, 3000)

    class_name = e.currentTarget.className
    @_toggle_mode_change(@model.id, class_name)

  delete: (e) ->
    #if confirm 'カテゴリを削除します。よろしいですか？'
    $(@el).fadeOut 'slow', () =>
      @remove()
      @model.destroy()

  render: ->
    data =
      category:
        name: @model.escape('name')
        id: @model.get('id')

    $(@el).html(@template.render(data)).fadeIn('slow')
    $('.mode_edit', @el).hide()

    @
