placeholder = view.util.findElemPlaceholder("qs", "index")
if placeholder
  view.util.fadeIn(placeholder, '<%= j(render partial: "index", locals: {qs: @qs}) %>')

view.qs.initRefreshBtn()