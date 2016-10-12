placeholder = view.util.findElemByDataAttributes(view.exam.placeholder_data_attributes)
if placeholder.length
  placeholder.html('<%= j(render partial: "list", locals: {exams: @exams, customer: @customer}) %>')

view.panelUtil.initToggleCollapseSwapIcon(placeholder)