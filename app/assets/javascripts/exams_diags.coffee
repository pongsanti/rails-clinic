# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
tExample = null
iRowcnt = 0

postData = (table)->
  postingData = {}

  counter = 0
  for row in table.data()
    postingData[counter++] =
      "order": row.order,
      "diag_id": row.id,
      "note": row.note

  console.log "exams_diags": postingData
  $.post('/exams_diags', "exams_diags": postingData,
    (data)-> console.log data,
    "json"
  )

addRow = (table)->

  id = $('#diags_select').val()
  title = $('button[data-id="diags_select"]').attr 'title'
  note = $("#exams_diags_note_text").val()
  row_to_add =
    id: id,
    order: ++iRowcnt,
    diag:
      name: title,
    note: note

  table.row.add(row_to_add).draw false

initializePage = ->
  # table initialization
  options = 
      columns: [
        ( data: "id", visible: false )
        ( data: "order", type: "num" )
        ( data: "diag.name" )
        ( data: "note" )
      ],
      bFilter: false,
      paging: false,
      ordering: false,
      info: false

  url = $("#example").data('url')
  # if existing data, render it
  if url?
    options.ajax =
        "url": url
        "dataSrc": "exams_diags"

  tExample = $('#example').DataTable options

  $("#exams_diags_add_row_btn").click ()->
    addRow(tExample)

  $("#exams_diags_submit_btn").click ()->
    postData(tExample)

$(document).ready(initializePage)
$(document).on('page:load', initializePage)
