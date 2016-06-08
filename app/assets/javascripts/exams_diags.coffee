# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
initializePage = ->
  # table initialization
  options = 
      "bFilter": false,
      "paging": false,
      "ordering": false,
      "info": false

  url = $("#example").data('url')
  # if existing data, render it
  if url?
    options.ajax =
        "url": url
        "dataSrc": "exams_diags"
    options.columns = [
        { "data": "id" },
        { "data": "diag.name" },
        { "data": "diag.description" }
      ]

  $('#example').DataTable options

$(document).ready(initializePage)
$(document).on('page:load', initializePage)