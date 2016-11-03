class constant
  CUSTOMER: 'customers'
  CLIENT: 'clients'
  DIAG: 'diags'
  EXAM: 'exam'
  STORE_UNIT: 'store_unit'
  DRUG_USAGE: "drug_usage"
  DRUG: "drugs"
  DRUG_IN: "drug_in"
  DRUG_MOVEMENT: "drug_movement"
  USER: "user"

class util

  jqRify: (obj) ->
    if obj.jquery?
      obj
    else
      $(obj)

  select: (phrase, parent=null) ->
    if parent?
      @jqRify(parent).find(phrase)
    else
      $(phrase)

  data_attr: (data_attr_name) ->
    "data-#{data_attr_name}"

  data_select: (data_name, value) ->
    "[#{@data_attr(data_name)}=\"#{value}\"]"

  hashObjectToJqPhrase:(hashObj) ->
    phrase = ''
    $.each(hashObj, (key, value) =>
      phrase = phrase + @data_select(key, value)
    )
    phrase


  initTooltips: (parent=null) ->
    phrase = "[data-toggle='tooltip']"
    @select(phrase, parent).tooltip()

  initializeSelectPicker: (parent=null) ->
    phrase = "select.selectpicker"
    @select(phrase, parent).selectpicker("refresh")

  findElemByDataAttributes: (hashObj) ->
    phrase = @hashObjectToJqPhrase(hashObj)
    $(phrase)

  findDivElemByDataAttrValue: (elem, dataAttr) ->
    $("div#{@jqRify(elem).data(dataAttr)}")

  findAnchorWithDataAttribute: (hashObj, parent=null)->
    phrase = @hashObjectToJqPhrase(hashObj)
    @select(phrase, parent)

  isUrlOf: (url, controller) ->
    url.indexOf(controller) != -1

  displayThaiYear: (objs) ->
    objs.each(
      (index, value) ->
        option = $(value)
        year = parseInt(option.text())
        option.text(year + ' (' + String(year + 543) + ')')
    )

  displayMonthNumber: (objs) ->
    objs.each(
      (index, value) ->
        option = $(value)
        # there are cases when index is greater than 12, so mod it with 12
        option.text(option.text() + ' (' + String(index%12 + 1) + ')');
    )

  strIsValidNumber: (str) ->
    return str? and typeof(str) is 'string' and (not isNaN(str))

  toF: (str) ->
    parseFloat(str)

  round: (f) ->
    f.toFixed(2)

class panelUtil
  initToggleCollapseSwapIcon: (placeholders) ->
    if placeholders.length
      placeholders.each (i, placeholder) ->
        $(placeholder).find("button[data-toggle='collapse']").each (index, btn) ->
          content_div = view.util.findDivElemByDataAttrValue($(btn), "target")
          #Remove all event handlers
          content_div.off()

          content_div.on("show.bs.collapse", () -> 
            $(btn).find("i.fa").removeClass("fa-toggle-down").addClass("fa-toggle-up")
          )

          content_div.on("hide.bs.collapse", () -> 
            $(btn).find("i.fa").removeClass("fa-toggle-up").addClass("fa-toggle-down")
          )

class formUtil
  clientSideValidation: () ->
    $('form').each (index, form) ->
      $(form).validate()

  initFieldsWithErrors: () ->
    $("div.field_with_errors").addClass("has-error")

#  fadeIn: (parent, content) ->
#    parent.html(content).hide().fadeIn()

window.view.const = new constant
window.view.util = new util
window.view.formUtil = new formUtil
window.view.panelUtil = new panelUtil


#@gInitSelectPicker = (parent) ->
#  parent.find('select.selectpicker').selectpicker('refresh')

initializePage = ->
  # init form validation
  view.formUtil.clientSideValidation()

  # enable bootstrap tooltip
  view.util.initTooltips()

  # select pickers
 # if $('form').find('button[data-toggle="dropdown"]').length is 0
 #   gInitSelectPicker $('form')

  # load customer queue
  view.qs.fetchAjaxContent()
  view.exam.fetchAjaxContent()
  view.drug_in.fetchAjaxContent()

  url = event.data.url
  # customer
  if view.util.isUrlOf(url, view.const.CUSTOMER)
    view.customer.initializePage()

  if view.util.isUrlOf(url, view.const.CLIENT)
    view.client.initializePage()

  if view.util.isUrlOf(url, view.const.DIAG)
    view.diag.initializePage()

  if view.util.isUrlOf(url, view.const.EXAM)
    view.exam.initializePage()

  if view.util.isUrlOf(url, view.const.STORE_UNIT)
    view.store_unit.initializePage()

  if view.util.isUrlOf(url, view.const.DRUG_USAGE)
    view.drug_usage.initializePage()

  if view.util.isUrlOf(url, view.const.DRUG)
    view.drug.initializePage()

  if view.util.isUrlOf(url, view.const.DRUG_IN)
    view.drug_in.initializePage()

  if view.util.isUrlOf(url, view.const.DRUG_MOVEMENT)
    view.drug_movement.initializePage()

  if view.util.isUrlOf(url, view.const.USER)
    view.user.initializePage()
    
  # refresh select picker
  view.util.initializeSelectPicker()

  view.formUtil.initFieldsWithErrors()
  
$(document).on('turbolinks:load', initializePage)