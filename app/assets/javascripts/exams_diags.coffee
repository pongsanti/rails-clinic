# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
initializePage = ->
  # table initialization
  $('#example').DataTable
    "ajax":
      "url": $("#example").data('url'),
      "dataSrc": "exams_diags",
    "columns": [
      { "data": "id" },
      { "data": "diag.name" },
      { "data": "diag.description" }
    ],
    "bFilter": false,
    "paging": false,
    "ordering": false,
    "info": false

$(document).ready(initializePage)
$(document).on('page:load', initializePage)