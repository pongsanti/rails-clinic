# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
initializePage = ->
  # new exam button click ajax error
  $('a[href*="new_exam_diag"]').on 'ajax:error', (event, xhr, status, error)-> gShowErrorModal error

  # append anchor to form action url
  $('form').each (index, form) ->
    f = $(form)
    anchor = f.data('anchor')
    if anchor?
      action = f.attr 'action'
      f.attr 'action', "#{action}#" + anchor

$(document).on('turbolinks:load', initializePage)  