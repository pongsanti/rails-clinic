# Global Variables
@gVar = 
  # It is always false, true means page has been loaded by turbolinks
  bLoadedWithTurbolinks : false

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

requestQueueList = ->
  $.post '/qs_poll', (data) ->
    div = $('#sidebar div[class="list-group"]')
    div.empty()

    div.html(HandlebarsTemplates['qs/items'](data))
    $('#queue_badge').html data.qs.length

# queue retrieval function
getQueueList = ->
  requestQueueList()
  setTimeout getQueueList, 20000

initializePage = ->
  # init form validation
  gInitFormValidation($('form'))

  # enable bootstrap tooltip
  $('[data-toggle="tooltip"]').tooltip()

  # request queue list at once
  requestQueueList()

  # enable queue polling
  if not gVar.bLoadedWithTurbolinks
    getQueueList()

  # select pickers
  if $('form').find('button[data-toggle="dropdown"]').length is 0
    gInitSelectPicker $('form')

  gVar.bLoadedWithTurbolinks = true

  react_div_id = "react_div"
  react_div = $("#{react_div_id}")
  if react_div
    window.render_drug_select(react_div_id);

$(document).on('turbolinks:load', initializePage)