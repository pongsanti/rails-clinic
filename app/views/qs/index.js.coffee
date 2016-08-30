placeholder = view.util.findElemPlaceholder(view.qs.controller, view.qs.action)
if placeholder.length
  placeholder.html('<%= j(render partial: "index", locals: {qs: @qs}) %>')

view.qs.showLoadingIcon(false)
view.util.initTooltips()
view.panelUtil.initToggleCollapseSwapIcon(placeholder)