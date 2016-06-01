# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
initializePage = ->
  # form validation
  $('form[id*="exam"]').each(
    (index, value) ->
      $(value).validate()
  )

$(document).ready(initializePage)
$(document).on('page:load', initializePage)  