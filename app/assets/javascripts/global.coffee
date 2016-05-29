Turbolinks.enableProgressBar()

# queue retrieval function
examQueueTemplate = (item) -> 
  "<a href='#' class='list-group-item list-group-item-info'>#{item.exam.id} #{item.exam.customer.name} #{item.exam.customer.surname}</a>"

getQueueList = ->
  $.post('/qs_poll', (data) ->
    div = $('#sidebar div[class="list-group"]')
    div.empty()
    $.each( data.qs, (i, item) ->
      div.append examQueueTemplate(item)
    )
    $('#queue_badge').html data.qs.length
  )
  setTimeout(getQueueList, 5000)

initializePage = ->
  # enable bootstrap tooltip
  $('[data-toggle="tooltip"]').tooltip()

  # enable queue polling
  getQueueList()

$(document).ready(initializePage)
$(document).on('page:load', initializePage)