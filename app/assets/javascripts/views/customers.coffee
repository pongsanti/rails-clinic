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
    $('input[type=radio]:checked').parent().button("toggle")


  initializePage: () ->
    @displayThaiYear()
    @displayMonthNumber()
    @preSelectSex()
    view.panelUtil.initToggleCollapseSwapIcon $("#searchPanel")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='customer']")

  initializePrefixSelectSex: ()->
    prefix_select = $("select[id*='customer_prefix']")

    prefix_select.change (evt) =>
      sex_selected_value = prefix_select.find("option:selected").data("sex")
      $("\##{sex_selected_value}_btn").button("toggle")


view.customer = new Customer