window.view = {}

class constant
  CUSTOMER: 'customers'
  DIAG: 'diags'
  EXAM: 'exam'

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

  initTooltips: (parent=null) ->
    phrase = "[data-toggle='tooltip']"
    @select(phrase, parent).tooltip()

  initializeSelectPicker: (parent=null) ->
    phrase = "select.selectpicker"
    @select(phrase, parent).selectpicker("refresh")

  findElemByDataAttributes: (hashObj) ->
    phrase = ''
    $.each(hashObj, (key, value) =>
      phrase = phrase + @data_select(key, value)
    )
    return $(phrase)

  findElementWithDataValue: (dataAttrName, value) ->
    select_stmt = "[data-#{dataAttrName}=\"#{value}\"]"
    return @jqRify(select_stmt)    

  findDivOnElementDataAttrValue: (elem, dataAttr) ->
    value = elem.data(dataAttr)
    return $("div#{value}")

  isUrlOf: (url, controller) ->
    url.indexOf(controller) != -1

class panelUtil
  initToggleCollapseSwapIcon: (placeholders) ->
    if placeholders.length
      placeholders.each (i, placeholder) ->
        $(placeholder).find("button[data-toggle='collapse']").each (index, btn) ->
          content_div = view.util.findDivOnElementDataAttrValue($(btn), "target")
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


# Global Functions
@gShowErrorModal = (text) ->
  modal = $('#modal_div')
  modal.find('div.modal-body').html text
  modal.modal('toggle')

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

  url = event.data.url
  # customer
  if view.util.isUrlOf(url, view.const.CUSTOMER)
    view.customer.initializePage()

  if view.util.isUrlOf(url, view.const.DIAG)
    view.diag.initializePage()

  if view.util.isUrlOf(url, view.const.EXAM)
    view.exam.initializePage()
    
  # refresh select picker
  view.util.initializeSelectPicker()

  view.formUtil.initFieldsWithErrors()
  
$(document).on('turbolinks:load', initializePage)