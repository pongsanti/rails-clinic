class DataTable

  table: null

  constructor: (@new_entry_btn_id) ->

  initializeTable: ()->
    placeholder = view.util.findElemByDataAttributes {"table": @tableName}
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

  addAttr: (obj, name, val) ->
    obj.attr(name, val)

  addClass: (obj, clsName) ->
    obj.addClass(clsName)    


class window.view.ExamDiagDataTable extends DataTable
  tableName: "examDiag"

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
    return [ "", diags_div[0].innerHTML, input, delete_icon ]

  deleteRowBtnEvent: (elem)->
    row = $(elem).closest('tr')
    @table.row(row[0]).remove().draw(false)


class window.view.ExamDrugDataTable extends DataTable
  tableName: "examDrug"

  rowContent: () ->
    drug_ins_div = $("\##{@drug_ins_div_id}").clone()
    drug_in_select = drug_ins_div.find("select")
    drug_in_select.addClass("selectpicker")

    drug_usages_div = $("\##{@drug_usages_div_id}").clone()
    drug_usage_select = drug_usages_div.find("select")
    drug_usage_select.addClass("selectpicker")

    rowId = Date.now()
    @addAttr(drug_in_select, "id", "exam_patient_drugs_attributes_#{rowId}_drug_in_id")
    @addAttr(drug_in_select, "name", "exam[patient_drugs_attributes][#{rowId}][drug_in_id]")

    @addAttr(drug_usage_select, "id", "exam_patient_drugs_attributes_#{rowId}_drug_usage_id")
    @addAttr(drug_usage_select, "name", "exam[patient_drugs_attributes][#{rowId}][drug_usage_id]")

    amount_input_id = "exam_patient_drugs_attributes_#{rowId}_amount"
    amount_input_name = "exam[patient_drugs_attributes][#{rowId}][amount]"
    amount_input = "<input id='#{amount_input_id}' name='#{amount_input_name}' type='text' style='width: 100%' class='form-control'>"

    revenue_input_id = "exam_patient_drugs_attributes_#{rowId}_revenue"
    revenue_input_name = "exam[patient_drugs_attributes][#{rowId}][revenue]"
    revenue_input = "<input id='#{revenue_input_id}' name='#{revenue_input_name}' type='text' style='width: 100%' class='form-control'>"      

    delete_id = "delete_#{rowId}"
    delete_icon = 
    """
      <button id="#{delete_id}" type="button" class="btn btn-danger btn-xs" onclick="view.exam.drugTable.deleteRowBtnEvent(this)">
        <span class="glyphicon glyphicon-trash"></i>
      </button>
    """
    return [ "", drug_ins_div[0].innerHTML, drug_usages_div[0].innerHTML, amount_input, revenue_input, delete_icon ]

  deleteRowBtnEvent: (elem)->
    row = $(elem).closest('tr')
    @table.row(row[0]).remove().draw(false)      