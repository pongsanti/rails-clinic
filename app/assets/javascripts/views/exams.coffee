# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Exam

  controller: "exams"
  action: "index"

  diagTable: null
  diags_div_id: "diags_div"

  initializePage: () ->
    view.panelUtil.initToggleCollapseSwapIcon $("div#customerShow")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='exam']")

    table = view.util.findElementWithDataValue("table", "true")
    if table.length
      @diagTable = table.DataTable
        "paging"    :false,
        "ordering"  :false,
        "info"      :false,
        "searching" :false

      @diagTable.on( 'draw.dt', ()-> 
        #console.log 'Redraw occurred at: '+new Date().getTime()
        view.exam.diagTable.$('select.selectpicker').selectpicker("refresh")
      )
    else
      @diagTable = null

  fetchAjaxContent: ()->
    placeholder = view.util.findElemPlaceholder(@controller, @action)
    if placeholder.length
      @loadIndex(placeholder)

  loadIndex: (placeholder)->
    anchor = placeholder.find("a")
    if anchor.length
      anchor.trigger("click.rails")

  submitDiagTable: () ->
    console.log @diagTable.$('input, select').serialize();

  addRow: () ->
    diags_div = $("\##{@diags_div_id}").clone()
    select = diags_div.find("select")
    select.addClass("selectpicker")
    rowNum = Date.now()
    select.attr("id", "exam_patient_diags_attributes_#{rowNum}_diag_id")
    select.attr("name", "exam[patient_diags_attributes][#{rowNum}][diag_id]")

    input_id = "exam_patient_diags_attributes_#{rowNum}_note"
    input_name = "exam[patient_diags_attributes][#{rowNum}][note]"
    input = "<input id='#{input_id}' name='#{input_name}' type='text' class='form-control'>"

    @diagTable.row.add([
            diags_div[0].innerHTML,
            input,
            ""            
        ]).draw( false );

  lastRow: () ->
    @diagTable.row(@rowCount - 1)

  rowCount: () ->
    @diagTable.rows().count()


view.exam = new Exam

#drug_drug_ins_path_pattern = (drug_id)->
#  "/drugs/#{drug_id}/drug_ins"

#initializePage = ->
  # new exam button click ajax error
  #$('a[href*="new_patient_diag"]').on 'ajax:error', (event, xhr, status, error)-> gShowErrorModal error

  # append anchor to form action url
  #$('form').each (index, form) ->
  #  f = $(form)
  #  anchor = f.data('anchor')
  #  if anchor?
  #    action = f.attr 'action'
  #    f.attr 'action', "#{action}#" + anchor

  # drug id
  #$('select#drug_in_drug_id').on "change", ()->
  #  $('a#link_drug_drug_ins_path').attr("href", drug_drug_ins_path_pattern(this.value) )

#$(document).on('turbolinks:load', initializePage)

