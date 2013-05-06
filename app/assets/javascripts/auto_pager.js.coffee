#----------------------------------------------
# AutoPager
#----------------------------------------------
(($)->
  $.AutoPager = (options) ->
    defaults =
      content: ''
      start: () ->
      before_append: (content) ->
        return content
      loaded: () ->

    _ = this;

    # init
    options = {} if options == undefined

    _.options = $.fn.extend(defaults, options)

    content = $(_.options.content).filter(':last');
    active = false
    page_num   = 1
    current_url = window.location.href

    #---------------------------
    # init
    #---------------------------
    _.init = () ->
      $(window).scroll(_.load_on_scroll);

    #---------------------------
    # load_on_scroll
    #---------------------------
    _.load_on_scroll = () ->
      if $(document).height() - $(window).height() - $(document).scrollTop() <= 0
        _.load()

    #---------------------------
    # load
    #---------------------------
    _.load = () ->
      return if active

      active = true;
      page_num += 1
      data =
        page: page_num
      $.get(current_url, data, _.append_content)
      return _

    #---------------------------
    # append_content
    #---------------------------
    _.append_content = (res)->
      next_content = $(res).find(_.options.content)

      # before append
      modified_content = _.options.before_append($(res).find(_.options.content))

      content.append(modified_content.children())

      # recall
      _.options.loaded($(res).find(_.options.content), page_num)

      active = false

    #---------------------------
    # main
    #---------------------------
    _.init()

)(jQuery);