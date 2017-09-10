# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
show_section_history = (a) ->
  elements = document.getElementById("data_output").childNodes
  for e in elements
    number = parseInt( e.id, 10 );
    unless number in [a]
      $(e).hide()
    else
      $(e).show()

$(document).on 'turbolinks:load', ->
  $('.history_link').click -> 
    show_section_history($(this).data('party'))
