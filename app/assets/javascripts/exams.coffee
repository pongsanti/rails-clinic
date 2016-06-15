# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
initializePage = ->
  # form validation
  $('form[id*="exam"]').each(
    (index, value) ->
      $(value).validate()
  )

  $('form[action*="new_exam_diag"]').on('ajax:error', (event, xhr, status, error)->
    modal = $('#modal_div')
    modal.find('div.modal-body').html error
    modal.modal('toggle')
  )
###
  $('form[action*="exam_diag"], a[href*="exam_diag"]').on('ajax:success', (event, xhr, status)->
    bstrapSelect()
    $(this).validate()
  )
###

$(document).ready(initializePage)
$(document).on('page:load', initializePage)  