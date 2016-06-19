
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

bstrapSelect = ->
  # initialize select picker
  $('.selectpicker').selectpicker({
    size: 'auto',
    liveSearch: true,
  })

# queue retrieval function
getQueueList = ->
  $.post('/qs_poll', (data) ->
    div = $('#sidebar div[class="list-group"]')
    div.empty()

    div.html(HandlebarsTemplates['qs/items'](data))
    $('#queue_badge').html data.qs.length
  )
  queueTimer = setTimeout(getQueueList, 10000)

initializePage = ->
  # enable bootstrap tooltip
  $('[data-toggle="tooltip"]').tooltip()

  # enable queue polling
  getQueueList()

  bstrapSelect()

$(document).ready(initializePage)
$(document).on('turbolinks:load', initializePage)