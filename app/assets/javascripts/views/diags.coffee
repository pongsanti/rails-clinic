# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Diag
  initializePage: () ->
    view.panelUtil.initToggleCollapseSwapIcon($("#searchPanel"))
    view.panelUtil.initToggleCollapseSwapIcon($("#diagIndex"))
    view.panelUtil.initToggleCollapseSwapIcon($("#diagShow"))

view.diag = new Diag
