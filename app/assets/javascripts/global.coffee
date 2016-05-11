Turbolinks.enableProgressBar()

initializePage = ->
  # enable bootstrap tooltip
  $('[data-toggle="tooltip"]').tooltip()

$(document).ready(initializePage)
$(document).on('page:load', initializePage)