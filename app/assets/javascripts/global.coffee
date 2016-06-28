# Global Variables
gQueueTimer = null

# Global Functions
@gShowErrorModal = (text) ->
  modal = $('#modal_div')
  modal.find('div.modal-body').html text
  modal.modal('toggle')

@gInitSelectPicker = (parent) ->
  parent.find('select.selectpicker').selectpicker('refresh')

@gInitFormValidation = (form) ->
  form.each (index, value) ->
    $(value).validate()

# queue retrieval function
getQueueList = ->
  $.post('/qs_poll', (data) ->
    div = $('#sidebar div[class="list-group"]')
    div.empty()

    div.html(HandlebarsTemplates['qs/items'](data))
    $('#queue_badge').html data.qs.length
  )
  gQueueTimer = setTimeout(getQueueList, 10000)

initializePage = ->
  # enable bootstrap tooltip
  $('[data-toggle="tooltip"]').tooltip()

  # enable queue polling
  if not gQueueTimer?
    getQueueList()

  # select pickers
  if $('form').find('button[data-toggle="dropdown"]').length is 0
    gInitSelectPicker $('form')

$(document).on('turbolinks:load', initializePage)