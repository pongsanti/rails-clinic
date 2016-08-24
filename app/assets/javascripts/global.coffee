window.view = {}

class constant
  CUSTOMER: 'customers'

class util

  initTooltips: () ->
    $('[data-toggle="tooltip"]').tooltip()

  initializeSelectPicker: () ->
    $('select.selectpicker').selectpicker('refresh')

  findElemPlaceholder: (controller, action) ->
    select_controller = "[data-controller=\"#{controller}\"]"
    select_action = "[data-action=\"#{action}\"]"
    $("div#{select_controller}#{select_action}")

  findElementWithDataValue: (dataAttrName, value) ->
    select_stmt = "[data-#{dataAttrName}=\"#{value}\"]"
    return $(select_stmt)

  isUrlOf: (url, controller) ->
    url.indexOf(view.const.CUSTOMER) != -1

class formUtil
  clientSideValidation: () ->
    $('form').each (index, form) ->
      $(form).validate()

  initFieldsWithErrors: () ->
    $("div.field_with_errors").addClass("has-error")

#  fadeIn: (parent, content) ->
#    parent.html(content).hide().fadeIn()

window.view.const = new constant
window.view.util = new util
window.view.formUtil = new formUtil


# Global Functions
@gShowErrorModal = (text) ->
  modal = $('#modal_div')
  modal.find('div.modal-body').html text
  modal.modal('toggle')

#@gInitSelectPicker = (parent) ->
#  parent.find('select.selectpicker').selectpicker('refresh')

initializePage = ->
  # init form validation
  view.formUtil.clientSideValidation()

  # enable bootstrap tooltip
  view.util.initTooltips()

  # select pickers
 # if $('form').find('button[data-toggle="dropdown"]').length is 0
 #   gInitSelectPicker $('form')

  # load customer queue
  view.qs.loadIndex()


  url = event.data.url
  # customer
  if view.util.isUrlOf(url, view.const.CUSTOMER)
    view.customer.initializePage()
    
  # refresh select picker
  view.util.initializeSelectPicker()

  view.formUtil.initFieldsWithErrors()
  
$(document).on('turbolinks:load', initializePage)