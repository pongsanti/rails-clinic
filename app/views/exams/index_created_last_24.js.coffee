placeholder = view.util.findElemByDataAttributes(view.exam.last24_placeholder_attr)
if placeholder.length
  placeholder.html('<%= j(render partial: "exams/last24/list", locals: {exams: @exams }) %>')

view.panelUtil.initToggleCollapseSwapIcon(placeholder)