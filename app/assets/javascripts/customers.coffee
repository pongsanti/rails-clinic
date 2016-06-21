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

  # display month number
  $('select#customer_birthdate_2i option').each(
    (index, value) ->
      option = $(value)
      option.text(option.text() + ' (' + String(index + 1) + ')');
  )

  # form validation
  gInitFormValidation $('form[id*="customer"]')

  # active the radio buttons group
  $('input[type=radio]:checked').parent().addClass('active')

  # on search form submit
  $('form').submit(
    (event) -> 
      sel_attr = $('#q_name').val()
      $('#cont').attr('name', "q[#{sel_attr}_cont]")
  )

$(document).on('turbolinks:load', initializePage)