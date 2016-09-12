# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Drug

  initializePage: () ->
    view.panelUtil.initToggleCollapseSwapIcon $("#searchPanel")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='drug']")

view.drug = new Drug