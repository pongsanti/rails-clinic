placeholder = view.util.findElemByDataAttributes(view.drug_in.placeholder_data_attributes)
if placeholder.length
  placeholder.html('<%= j(render partial: "side_list", locals: {drug_ins: @drug_ins}) %>')

view.panelUtil.initToggleCollapseSwapIcon(placeholder)