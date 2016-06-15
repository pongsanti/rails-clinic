# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
initializePage = ->
  # form validation
  $('form[id*="exam"]').each(
    (index, value) ->
      $(value).validate()
  )

###
  $('form[action*="exam_diag"]').on('ajax:error', (event, xhr, status, error)->
    $(this).append(error)
  )

  $('form[action*="exam_diag"], a[href*="exam_diag"]').on('ajax:success', (event, xhr, status)->
    bstrapSelect()
    $(this).validate()
  )
###

$(document).ready(initializePage)
$(document).on('page:load', initializePage)  