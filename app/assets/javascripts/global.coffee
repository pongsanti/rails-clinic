Turbolinks.enableProgressBar()

# queue retrieval function
examQueueTemplate = (item) -> 
  "<a href='#' class='list-group-item list-group-item-info'>#{item.id} #{item.customer.name} #{item.customer.surname}</a>"

getQueueList = ->
  $.post('/exams_poll', (data) ->
    div = $('#sidebar div[class="list-group"]')
    div.empty()
    $.each( data.exams, (i, item) ->
      div.append examQueueTemplate(item)
    )
    $('#queue_badge').html data.exams.length
  )
  setTimeout(getQueueList, 5000)

initializePage = ->
  # enable bootstrap tooltip
  $('[data-toggle="tooltip"]').tooltip()

  # enable queue polling
  getQueueList()

$(document).ready(initializePage)
$(document).on('page:load', initializePage)