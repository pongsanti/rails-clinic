Turbolinks.enableProgressBar()

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

    # initialize select picker
  $('.selectpicker').selectpicker({
    size: 'auto',
    liveSearch: true,
  })

$(document).ready(initializePage)
$(document).on('page:load', initializePage)