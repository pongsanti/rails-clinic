placeholder = view.util.findElemPlaceholder(view.exam.controller, view.exam.action)
if placeholder.length
  placeholder.html('<%= j(render partial: "list") %>')

view.panelUtil.initToggleCollapseSwapIcon(placeholder)