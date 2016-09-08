# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class DrugIn

  initializePage: () ->
    view.panelUtil.initToggleCollapseSwapIcon $("#searchPanel")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='drugIn']")

view.drug_in = new DrugIn

#initializePage = -> # display local year
#  $('select#drug_in_expired_date_1i option').each(
#    (index, value) ->
#      option = $(value)
#      year = parseInt(option.text())
#      option.text(year + ' (' + String(year + 543) + ')')
#  )

  # display month number
#  $('select#drug_in_expired_date_2i option').each(
#    (index, value) ->
#      option = $(value)
#      option.text(option.text() + ' (' + String(index + 1) + ')');
#  )

#$(document).on('turbolinks:load', initializePage)