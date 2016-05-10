Turbolinks.enableProgressBar()

initializePage = ->
  $('[data-toggle="offcanvas"]').click(
    () -> $('.row-offcanvas').toggleClass('active')
  )

$(document).ready(initializePage)
$(document).on('page:load', initializePage)