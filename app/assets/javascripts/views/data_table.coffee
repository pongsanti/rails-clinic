class DataTable

  table: null

  constructor: (@new_entry_btn_id, @util) ->
 
  initOptions: ()->
    "responsive":true,
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

  modelName: () ->
    # to be overridden

  addAttr: (obj, name, val) ->
    obj.attr(name, val)

  addClass: (obj, clsName) ->
    obj.addClass(clsName)

  createInput: (objParamName, id, method) ->
    idAttr = @createIdAttr(objParamName, id, method)
    nameAttr = @createNameAttr(objParamName, id, method)
    "<input id='#{idAttr}' name='#{nameAttr}' type='text' style='width: 100%' class='form-control'>"

  createDeleteButton: (id) ->
    """
      <button id="#{id}" type="button" class="btn btn-danger btn-xs">
        <span class="glyphicon glyphicon-trash"></i>
      </button>
    """

  createIdAttr: (objParamName, id, method) ->
    "#{@modelName()}_#{objParamName}_#{id}_#{method}"

  createNameAttr: (objParamName, id, method) ->
    "#{@modelName()}[#{objParamName}][#{id}][#{method}]"

  createAttribute: (obj, objParamName, id, method) ->
    @addAttr(obj, "id", @createIdAttr(objParamName, id, method))
    @addAttr(obj, "name", @createNameAttr(objParamName, id, method))

  formatNumber: (num)->
    num.toFixed(2)

  deleteButtonClickEvent: (clickEvent) =>
    row = $(clickEvent.data)
    @table.row(row[0]).remove().draw(false)

class window.view.ExamDiagDataTable extends DataTable
  tableName: "examDiag"
  objParamName: "patient_diags_attributes"
  
  modelName: () ->
    "exam"
   
  initOptions: () ->
    $.extend(super, 
      "createdRow": ( row, data, index ) =>
          @util.jqRify(row).find("button[id*='delete']").click(row, @deleteButtonClickEvent)
    )     

  rowContent: () ->
    diags_div = $("\##{@diags_div_id}").clone()
    select = diags_div.find("select")
    @addClass(select, "selectpicker")

    rowId = Date.now()
    @createAttribute(select, @objParamName, rowId, "diag_id")

    input = @createInput(@objParamName, rowId, "note")

    delete_icon = @createDeleteButton("delete_#{rowId}")

    return [ "", diags_div[0].innerHTML, input, delete_icon ]

  deleteRowBtnEvent: (elem)->
    row = $(elem).closest('tr')
    @table.row(row[0]).remove().draw(false)


class window.view.ExamDrugDataTable extends DataTable
  tableName: "examDrug"
  objParamName: "patient_drugs_attributes"

  modelName: () ->
    "exam"

  initOptions: () ->
    $.extend(super, 
      "createdRow": ( row, data, index ) =>
          @util.jqRify(row).find("button[id*='delete']").click(row, @deleteButtonClickEvent)
          @util.jqRify(row).find("select[id*='drug_in']").change(row, @drugInSelectChangeEvent)
          @util.jqRify(row).find("input[id*='amount']").change(row, @amountTextInputChangeEvent)
    )  

  rowContent: () ->
    drug_ins_div = $("\##{@drug_ins_div_id}").clone()
    drug_in_select = drug_ins_div.find("select")
    @addClass(drug_in_select, "selectpicker")

    drug_usages_div = $("\##{@drug_usages_div_id}").clone()
    drug_usage_select = drug_usages_div.find("select")
    @addClass(drug_usage_select, "selectpicker")

    rowId = Date.now()
    @createAttribute(drug_in_select, @objParamName, rowId, "drug_in_id")
    @createAttribute(drug_usage_select, @objParamName, rowId, "drug_usage_id")

    amount_input = @createInput(@objParamName, rowId, "amount")
    revenue_input = @createInput(@objParamName, rowId, "revenue")

    delete_icon = @createDeleteButton("delete_#{rowId}")

    return [ "", drug_ins_div[0].innerHTML, drug_usages_div[0].innerHTML, amount_input, revenue_input, delete_icon ]

  amountValue: (row)->
    row.find("input[id*='amount']").val()

  setRevenueValue: (row, value)->
    revenueTextInput = row.find("input[id*='revenue']").val(value)

  optionSalePriceValue: (row) =>
    row.find("option:selected").data("sale")

  drugInSelectChangeEvent: (changeEvent)=>
    row = $(changeEvent.data)
    amount_value = @amountValue(row)
    if amount_value? and amount_value > 0
      option_sale_price_value = @util.jqRify(changeEvent.target).find("option:selected").data("sale")
      if option_sale_price_value?
        @setRevenueValue row, @formatNumber(option_sale_price_value * amount_value)
  
  amountTextInputChangeEvent: (changeEvent)=>
    row = $(changeEvent.data)
    amount_value = @amountValue(row)
    if amount_value? and amount_value > -1
      sale_price = @optionSalePriceValue(row)
      @setRevenueValue row, @formatNumber(sale_price * amount_value)
