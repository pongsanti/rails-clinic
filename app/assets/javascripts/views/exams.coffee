# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Exam

  controller: "exams"
  action: "index"
  diagTable: null

  initializePage: () ->
    view.panelUtil.initToggleCollapseSwapIcon $("div#customerShow")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='exam']")

    table = $('#example')
    if table.length
      @diagTable = table.DataTable
        "paging"    :false,
        "ordering"  :false,
        "info"      :false,
        "searching" :false
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
    select = """
      <select class="selectpicker" data-live-search="true" data-width="auto" id="row-1-office" name="row-1-office">
        <option value="Edinburgh" selected="selected">Edinburgh </option>
        <option value="London">London</option>
        <option value="New York">New York</option>
        <option value="San Francisco">San Francisco</option>
        <option value="Tokyo">Tokyo</option>
      </select>
    """
    @diagTable.row.add([
            select,
            "<input name='input-2' type='text' class='form-control' value='London'>",
            ""            
        ]).draw( false );

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

