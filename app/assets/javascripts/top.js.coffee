# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

bt = $("#sub_header_menu").offset().top
ds = 0

$(document).scroll ->
  ds = $(this).scrollTop()

  if (bt <= ds)
    $("#sub_header_menu").addClass('follow')
  else if (bt >= ds)
    $("#sub_header_menu").removeClass('follow')

