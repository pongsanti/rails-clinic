# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Customer

  displayThaiYear: () ->
    $('select#customer_birthdate_1i option').each(
      (index, value) ->
        option = $(value)
        year = parseInt(option.text())
        option.text(year + ' (' + String(year + 543) + ')')
    )

  displayMonthNumber: () ->
    $('select#customer_birthdate_2i option').each(
      (index, value) ->
        option = $(value)
        option.text(option.text() + ' (' + String(index + 1) + ')');
    )

  preSelectSex: () ->
    $('input[type=radio]:checked').parent().addClass('active')

  initializePage: () ->
    @displayThaiYear()
    @displayMonthNumber()
    @preSelectSex()
    view.panelUtil.initToggleCollapseSwapIcon($("#searchPanel"))
    view.panelUtil.initToggleCollapseSwapIcon($("#customerIndex"))
    view.panelUtil.initToggleCollapseSwapIcon($("#customerForm"))
    view.panelUtil.initToggleCollapseSwapIcon($("#customerShow"))

view.customer = new Customer