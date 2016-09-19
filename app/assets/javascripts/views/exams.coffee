# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class window.view.Revenue
  constructor: (@args)->

  exam: ()->
    @args.exam

  sum: ()->
    @args.sum

  exam_text_input: ()->
    @args.exam_elem

  sum_span: ()->
    @args.sum_elem

  diff: ()->
    @sum() - @exam()

  get_sum_for_exam: (val)->
    val + @diff()

  initialize:() ->
    @exam_text_input().keyup( 
      (evnt) =>
        current_val = @to_f(evnt.target.value)
        sum_val = @get_sum_for_exam(current_val)
        @sum_span().html(@format_sum(sum_val))
    )

  format_sum:(val) ->
    val.toFixed(2) + ' $'

  to_f:(str)->
    ret_val = 0.0
    if str? and str
      if not isNaN(str)
        ret_val = parseFloat(str)
    return ret_val

class Exam

  constructor: (@util)->

  placeholder_data_attributes:
    controller: "exams"
    action: "index"

  remoteContent: null

  #Diag
  diagTable: null
  diags_div_id: "diags_div"
  new_diag_btn_id: "new_diag"

  #Drug
  drugTable: null
  drug_ins_div_id: "drug_ins_div"
  drug_usages_div_id: "drug_usages_div"
  new_drug_btn_id: "new_drug"

  #Revenue
  revenue: null
  exam_revenue_form_div_id: "examRevenueFormBody"

  initializeRevenueForm: (args)->
    delete @revenue
    revenue_div = $("\##{@exam_revenue_form_div_id}")
    if revenue_div.length
      args.exam_elem = @util.select("input[id='exam_revenue']", revenue_div)
      args.sum_elem = @util.select("span[id='exam_revenue_sum']", revenue_div)
      @revenue = new view.Revenue(args)
      @revenue.initialize()
      


  initializePage: () ->
    view.panelUtil.initToggleCollapseSwapIcon $("div#customerShow")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='exam']")

    delete @diagTable
    @diagTable = new view.ExamDiagDataTable(@new_diag_btn_id, view.util)
    @diagTable.diags_div_id = @diags_div_id
    @diagTable.initializeTable()

    delete @drugTable
    @drugTable = new view.ExamDrugDataTable(@new_drug_btn_id, view.util)
    @drugTable.drug_ins_div_id = @drug_ins_div_id
    @drugTable.drug_usages_div_id = @drug_usages_div_id
    @drugTable.initializeTable()

  fetchAjaxContent: ()->
    if not @remoteContent?
      @remoteContent = new view.RemoteContent @placeholder_data_attributes

    @remoteContent.fetchAjaxContent()

#  submitDiagTable: () ->
#    console.log @diagTable.$('input, select').serialize();

#  lastRow: () ->
#    @diagTable.row(@rowCount - 1)

#  rowCount: () ->
#    @diagTable.rows().count()

view.exam = new Exam(view.util)