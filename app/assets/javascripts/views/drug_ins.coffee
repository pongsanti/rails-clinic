# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class DrugIn

  placeholder_data_attributes:
    controller: "drug_ins"
    action: "index"

  remoteContent: null

  initializePage: () ->
    @displayThaiYear()
    @displayMonthNumber()
    view.panelUtil.initToggleCollapseSwapIcon $("#searchPanel")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='drugIn']")

  fetchAjaxContent: ()->
    if not @remoteContent?
      @remoteContent = new view.RemoteContent @placeholder_data_attributes

    @remoteContent.fetchAjaxContent()

  displayThaiYear: () ->
    $('select#drug_in_expired_date_1i option').each(
      (index, value) ->
        option = $(value)
        year = parseInt(option.text())
        option.text(year + ' (' + String(year + 543) + ')')
    )

  displayMonthNumber: () ->
    $('select#drug_in_expired_date_2i option').each(
      (index, value) ->
        option = $(value)
        option.text(option.text() + ' (' + String(index + 1) + ')');
    )    
         
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