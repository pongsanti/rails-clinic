placeholder = view.util.findElemByDataAttributes(view.exam.placeholder_data_attributes)
if placeholder.length
  placeholder.html('<%= j(render partial: "list", locals: {drug_ins: @drug_ins}) %>')

view.panelUtil.initToggleCollapseSwapIcon(placeholder)