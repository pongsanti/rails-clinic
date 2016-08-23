window.view = {}

class constant
  CUSTOMER: 'customers'

class util

  findElemPlaceholder: (controller, action) ->
    select_controller = "[data-controller=\"#{controller}\"]"
    select_action = "[data-action=\"#{action}\"]"
    $("div#{select_controller}#{select_action}")

  findElementWithDataValue: (dataAttrName, value) ->
    select_stmt = "[data-#{dataAttrName}=\"#{value}\"]"
    return $(select_stmt)

  clientSideValidation: () ->
    $('form').each (index, form) ->
      $(form).validate()

  isUrlOf: (url, controller) ->
    url.indexOf(view.const.CUSTOMER) != -1

#  fadeIn: (parent, content) ->
#    parent.html(content).hide().fadeIn()

window.view.const = new constant
window.view.util = new util


# Global Functions
@gShowErrorModal = (text) ->
  modal = $('#modal_div')
  modal.find('div.modal-body').html text
  modal.modal('toggle')

@gInitSelectPicker = (parent) ->
  parent.find('select.selectpicker').selectpicker('refresh')

initializePage = ->
  # init form validation
  view.util.clientSideValidation()

  # enable bootstrap tooltip
  $('[data-toggle="tooltip"]').tooltip()

  # select pickers
  if $('form').find('button[data-toggle="dropdown"]').length is 0
    gInitSelectPicker $('form')

  # load customer queue
  view.qs.loadIndex()

  url = event.data.url
  # customer
  if view.util.isUrlOf(url, view.const.CUSTOMER)
    view.customer.initializePage()
    
$(document).on('turbolinks:load', initializePage)