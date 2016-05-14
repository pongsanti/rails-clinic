Turbolinks.enableProgressBar()

# queue retrieval function
getQueueList = ->
  $.post('/exams_poll', (data) ->
    div = $('#sidebar div[class="list-group"]')
    div.empty()
    $.each( data, (i, item) ->
      div.append "<a href='#' class='list-group-item list-group-item-info'>#{item.id}</a>"
    )
    $('#queue_badge').html data.length
  )
  setTimeout(getQueueList, 5000)

initializePage = ->
  # enable bootstrap tooltip
  $('[data-toggle="tooltip"]').tooltip()

  # enable queue polling
  getQueueList()

$(document).ready(initializePage)
$(document).on('page:load', initializePage)