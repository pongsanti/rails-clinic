# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

initializePage = -> # display local year
  $('select#customer_birthdate_1i option').each(
    (index, value) ->
      option = $(value)
      year = parseInt(option.text())
      option.text(year + ' (' + String(year + 543) + ')')
  )

  # initialize select picker
  $('.selectpicker').selectpicker({
    size: 'auto',
    liveSearch: true,
  })

  # form validation
  $('form[id*="customer"]').each(
    (index, value) ->
      $(value).validate()
  )

$(document).ready(initializePage)
$(document).on('page:load', initializePage)