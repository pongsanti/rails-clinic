window.view = {}

class util
  findDataDiv: (controller, action) ->
    select_controller = "[data-controller=\"#{controller}\"]"
    select_action = "[data-action=\"#{action}\"]"
    $("div#{select_controller}#{select_action}")

window.view.util = new util


# Global Functions
@gShowErrorModal = (text) ->
  modal = $('#modal_div')
  modal.find('div.modal-body').html text
  modal.modal('toggle')

@gInitSelectPicker = (parent) ->
  parent.find('select.selectpicker').selectpicker('refresh')

@gInitFormValidation = (forms) ->
  forms.each (index, form) ->
    $(form).validate()

initializePage = ->
  # init form validation
  gInitFormValidation($('form'))

  # enable bootstrap tooltip
  $('[data-toggle="tooltip"]').tooltip()

  # select pickers
  if $('form').find('button[data-toggle="dropdown"]').length is 0
    gInitSelectPicker $('form')

  # load customer queue
  view.qs.loadIndex()

$(document).on('turbolinks:load', initializePage)