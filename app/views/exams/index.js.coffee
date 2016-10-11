placeholder = view.util.findElemByDataAttributes(view.exam.placeholder_data_attributes)
if placeholder.length
  placeholder.html('<%= j(render_list) %>')

view.panelUtil.initToggleCollapseSwapIcon(placeholder)