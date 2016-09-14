class DataTable

  table: null

  constructor: (@new_entry_btn_id, @util) ->
 
  initOptions: ()->
    "paging"    :false,
    "ordering"  :false,
    "info"      :false,
    "searching" :false

  initializeTable: ()->
    placeholder = @util.findElemByDataAttributes {"table": @tableName}
    if placeholder.length
      @table = placeholder.DataTable @initOptions()
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

  createInput: (objParamName, id, method) ->
    idAttr = @createIdAttr(objParamName, id, method)
    nameAttr = @createNameAttr(objParamName, id, method)
    "<input id='#{idAttr}' name='#{nameAttr}' type='text' style='width: 100%' class='form-control'>"

  createDeleteButton: (id, onclickFunction) ->
    """
      <button id="#{id}" type="button" class="btn btn-danger btn-xs" onclick="#{onclickFunction}">
        <span class="glyphicon glyphicon-trash"></i>
      </button>
    """

  createIdAttr: (objParamName, id, method) ->
    "exam_#{objParamName}_#{id}_#{method}"

  createNameAttr: (objParamName, id, method) ->
    "exam[#{objParamName}][#{id}][#{method}]"

  createAttribute: (obj, objParamName, id, method) ->
    @addAttr(obj, "id", @createIdAttr(objParamName, id, method))
    @addAttr(obj, "name", @createNameAttr(objParamName, id, method))


class window.view.ExamDiagDataTable extends DataTable
  tableName: "examDiag"

  rowContent: () ->
    diags_div = $("\##{@diags_div_id}").clone()
    select = diags_div.find("select")
    @addClass(select, "selectpicker")

    rowId = Date.now()
    @createAttribute(select, "patient_diags_attributes", rowId, "diag_id")

    input = @createInput("patient_diags_attributes", rowId, "note")

    delete_icon = @createDeleteButton("delete_#{rowId}", "view.exam.diagTable.deleteRowBtnEvent(this)")

    return [ "", diags_div[0].innerHTML, input, delete_icon ]

  deleteRowBtnEvent: (elem)->
    row = $(elem).closest('tr')
    @table.row(row[0]).remove().draw(false)


class window.view.ExamDrugDataTable extends DataTable
  tableName: "examDrug"

  initOptions: () ->
    $.extend(super, 
      "createdRow": ( row, data, index ) =>
          @util.jqRify(row).find("select[id*='drug_in']").change(row, @drugInSelectChangeEvent)
    )  

  rowContent: () ->
    drug_ins_div = $("\##{@drug_ins_div_id}").clone()
    drug_in_select = drug_ins_div.find("select")
    @addClass(drug_in_select, "selectpicker")

    drug_usages_div = $("\##{@drug_usages_div_id}").clone()
    drug_usage_select = drug_usages_div.find("select")
    @addClass(drug_usage_select, "selectpicker")

    rowId = Date.now()
    @createAttribute(drug_in_select, "patient_drugs_attributes", rowId, "drug_in_id")
    @createAttribute(drug_usage_select, "patient_drugs_attributes", rowId, "drug_usage_id")

    amount_input = @createInput("patient_drugs_attributes", rowId, "amount")
    revenue_input = @createInput("patient_drugs_attributes", rowId, "revenue")

    delete_icon = @createDeleteButton("delete_#{rowId}", "view.exam.drugTable.deleteRowBtnEvent(this)")

    return [ "", drug_ins_div[0].innerHTML, drug_usages_div[0].innerHTML, amount_input, revenue_input, delete_icon ]

  deleteRowBtnEvent: (elem)->
    row = $(elem).closest('tr')
    @table.row(row[0]).remove().draw(false)

  drugInSelectChangeEvent: (changeEvent)=>
    row = $(changeEvent.data)
    amount_value = row.find("input[id*='amount']").val()
    if amount_value? and amount_value > 0
      option_sale_price_value = @util.jqRify(changeEvent.target).find("option:selected").data("sale")
      if option_sale_price_value?
        revenue_text_input = row.find("input[id*=revenue]")
        revenue_text_input.val (option_sale_price_value * amount_value).toFixed(2)