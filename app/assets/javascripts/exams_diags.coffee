# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
tExample = null
sExamId = null
sUrl = null

rowCount = (table) ->
  table.data().count()

postData = (table)->
  postingData =
    exam_id: sExamId
    exams_diags: []

  counter = 0
  for row in table.data()
    postingData.exams_diags.push
      "order": row.order,
      "diag_id": row.diag.id,
      "note": row.note

  $.post(sUrl, postingData,
    (data)-> console.log data,
    "json"
  )

addRow = (table)->

  id = $('#diags_select').val()
  title = $('button[data-id="diags_select"]').attr 'title'
  note = $("#exams_diags_note_text").val()
  row_to_add =
    order: rowCount(tExample) + 1,
    diag:
      id: id
      name: title,
    note: note

  table.row.add(row_to_add).draw false

initializePage = ->
  # get exam id
  sExamId =  $("#example").data 'exam-id'
  sUrl = $("#example").data('url')
  # table initialization
  options = 
      ajax:
        url: sUrl
        dataSrc: "exams_diags"
      columns: [
        ( data: "diag.id", visible: false )
        ( data: "order", type: "num" )
        ( data: "diag.name" )
        ( data: "note" )
      ],
      bFilter: false,
      paging: false,
      ordering: false,
      info: false

  tExample = $('#example').DataTable options

  # add new ros
  $("#exams_diags_add_row_btn").click ()->
    addRow(tExample)

  # post data
  $("#exams_diags_submit_btn").click ()->
    postData(tExample)

$(document).ready(initializePage)
$(document).on('page:load', initializePage)
