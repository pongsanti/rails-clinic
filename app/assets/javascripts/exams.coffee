# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
initializePage = ->
  # form validation
  $('form[id*="exam"]').each(
    (index, value) ->
      $(value).validate()
  )

  $('a[href*="new_exam_diag"]').on('ajax:error', (event, xhr, status, error)->
    modal = $('#modal_div')
    modal.find('div.modal-body').html error
    modal.modal('toggle')
  )

$(document).ready(initializePage)
$(document).on('page:load', initializePage)  