# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'turbolinks:load', ->
  $('.slider').on 'moved.zf.slider', ->
    sliVN = $(this).children('.slider-handle').attr('aria-valuenow')
    sliAC = $(this).children('.slider-handle').attr("aria-controls")
    curr = $(this).children('.slider-handle').attr("data-cur")
    
    sliAC = sliAC.split("s")[0]
    sliAC = '#' + sliAC + 'rest'
    item = $(sliAC)
    item.html( parseInt(item.html()) - ( parseInt(sliVN) - parseInt(curr) ) )
    $(this).children('.slider-handle').attr("data-cur",sliVN)
    
    if parseInt(item.html()) < 0
      item.css('color', '#ff0000')
      $('#sortSubmit').hide()
    else
      item.css('color', '#000000')
      $('#sortSubmit').show()
