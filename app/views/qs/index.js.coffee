placeholder = view.util.findElemPlaceholder("qs", "index")
if placeholder
  placeholder.html('<%= j(render partial: "index", locals: {qs: @qs}) %>')

view.qs.initRefreshBtn()
view.qs.showLoadingIcon(false);