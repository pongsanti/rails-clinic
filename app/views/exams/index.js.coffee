placeholder = view.util.findElemByDataAttributes(view.exam.index_placeholder_attr)
if placeholder.length
  placeholder.html('<%= j(render partial: "list", locals: {exams: @exams, customer: @customer}) %>')

view.panelUtil.initToggleCollapseSwapIcon(placeholder)