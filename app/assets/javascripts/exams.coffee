# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
initializePage = ->
  # new exam button click ajax error
  $('a[href*="new_exam_diag"]').on 'ajax:error', (event, xhr, status, error)-> gShowErrorModal error

$(document).ready(initializePage)
$(document).on('page:load', initializePage)  