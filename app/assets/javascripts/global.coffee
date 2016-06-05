Turbolinks.enableProgressBar()

# queue retrieval function
examQueueTemplate = (item) -> 
  "<a href='/qs/#{item.id}' data-method='delete' class='list-group-item'>" +
  "#{item.exam.id} | #{item.created} | #{item.exam.customer.name} #{item.exam.customer.surname}" +
  "</a>"


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

    # initialize select picker
  $('.selectpicker').selectpicker({
    size: 'auto',
    liveSearch: true,
  })

$(document).ready(initializePage)
$(document).on('page:load', initializePage)