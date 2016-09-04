placeholder = view.util.findElemByDataAttributes(view.qs.placeholder_data_attributes)

if placeholder.length
  placeholder.html('<%= j(render partial: "index", locals: {qs: @qs}) %>')

view.qs.showLoadingIcon(false)
view.util.initTooltips()
view.panelUtil.initToggleCollapseSwapIcon(placeholder)