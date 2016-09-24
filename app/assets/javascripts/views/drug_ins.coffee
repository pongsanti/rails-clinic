# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class DrugIn

  constructor: (@util)->

  placeholder_data_attributes:
    controller: "drug_ins"
    action: "index"

  remoteContent: null

  initializePage: () ->
    @util.displayThaiYear $("select[id*='drug_in_expired_date_1i'] option")
    @util.displayMonthNumber $("select[id*='drug_in_expired_date_2i'] option")
    view.panelUtil.initToggleCollapseSwapIcon $("#searchPanel")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='drugIn']")

  fetchAjaxContent: ()->
    if not @remoteContent?
      @remoteContent = new view.RemoteContent @placeholder_data_attributes

    @remoteContent.fetchAjaxContent()

  initializeForm: ()->
    calculate_price_per_unit_link = $('a#calculate_link')
    if calculate_price_per_unit_link.length
      calculate_price_per_unit_link.click (eventObj)=>
        amount_value = $("input[id*='amount']").val()
        cost_value = $("input[id*='cost']").val()

        if amount_value? and cost_value? and amount_value and cost_value
          if not isNaN(amount_value) and not isNaN(cost_value)
            price_per_unit_input = $("input[id*='price_per_unit']")
            if price_per_unit_input.length
              price_per_unit_input.val(parseFloat(cost_value/amount_value).toFixed(2))

        eventObj.preventDefault()
         
view.drug_in = new DrugIn(view.util)