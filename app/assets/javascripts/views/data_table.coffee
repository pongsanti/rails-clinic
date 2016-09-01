class DataTable

  table: null

  constructor: (@new_entry_btn_id) ->

  initializeTable: ()->
    placeholder = view.util.findElementWithDataValue("table", "true")
    if placeholder.length
      @table = placeholder.DataTable
        "paging"    :false,
        "ordering"  :false,
        "info"      :false,
        "searching" :false

      @addDrawEventHandler()
      @addNewEntryBtnEvent()
    else
      @table = null
    
  addDrawEventHandler: ()->
    @table.on 'draw.dt', ()=>
      @table.$('select.selectpicker').selectpicker("refresh")

  addNewEntryBtnEvent: ()->
    btn = $("\##{@new_entry_btn_id}")
    if btn.length
      btn.off()
      btn.click ()=>
        @addRow(@rowContent())

  addRow: (content) ->
    @table.row.add(content).draw( false )

  rowContent: () ->
    # to be overridden


class window.view.ExamDiagDataTable extends DataTable
  rowContent: () ->
    diags_div = $("\##{@diags_div_id}").clone()
    select = diags_div.find("select")
    select.addClass("selectpicker")

    rowId = Date.now()
    select.attr("id", "exam_patient_diags_attributes_#{rowId}_diag_id")
    select.attr("name", "exam[patient_diags_attributes][#{rowId}][diag_id]")

    input_id = "exam_patient_diags_attributes_#{rowId}_note"
    input_name = "exam[patient_diags_attributes][#{rowId}][note]"
    input = "<input id='#{input_id}' name='#{input_name}' type='text' style='width: 100%' class='form-control'>"

    delete_id = "delete_#{rowId}"
    delete_icon = 
    """
      <button id="#{delete_id}" type="button" class="btn btn-danger btn-xs" onclick="view.exam.diagTable.deleteRowBtnEvent(this)">
        <span class="glyphicon glyphicon-trash"></i>
      </button>
    """
    return [ diags_div[0].innerHTML, input, delete_icon ]

  deleteRowBtnEvent: (elem)->
    row = $(elem).closest('tr')
    @table.row(row[0]).remove().draw(false)    