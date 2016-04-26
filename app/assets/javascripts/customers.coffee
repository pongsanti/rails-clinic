# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(
	() -> # display local year
		$('select#customer_birthdate_1i option').each( 
			(index, value) ->
				option = $(value)
				year = parseInt(option.text())
				option.text(year + ' (' + String(year + 543) + ')')
		)

		$('.selectpicker').selectpicker({
			size: 'auto',
			liveSearch: true,
		})
)

$(document).ready(
	() -> # form validation
		$('form[id*="customer"]').each(
			(index, value) ->
				$(value).validate()
		)
)