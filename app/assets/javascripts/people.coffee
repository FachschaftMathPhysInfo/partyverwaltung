# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#searchInput').on 'input', ->
    menus = document.getElementsByClassName('persoLink')
    if $(this).val() == ''
      i = menus.length - 1
      while i >= 0
        menus[i].style.display = 'block'
        i--
    else
      i = menus.length - 1
      while i >= 0
        if menus[i].dataset.name.toLowerCase().indexOf($(this).val().toLowerCase()) != -1
          menus[i].style.display = 'block'
        else
          menus[i].style.display = 'none'
        i--
    return

$(document).on 'turbolinks:load', ->
  $('#vetBut').on 'click', ->
    menus = document.getElementsByClassName('persoLink')
    i = menus.length - 1
    while i >= 0
      if menus[i].dataset.stat == "1"
        menus[i].style.display = 'block'
      else
        menus[i].style.display = 'none'
      i--
    return

$(document).on 'turbolinks:load', ->
  $('#blackBut').on 'click', ->
    menus = document.getElementsByClassName('persoLink')
    i = menus.length - 1
    while i >= 0
      if menus[i].dataset.stat == "-1"
        menus[i].style.display = 'block'
      else
        menus[i].style.display = 'none'
      i--
    return
