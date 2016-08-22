placeholder = window.view.util.findDataDiv("qs", "index")
if placeholder
  placeholder.html('<%= j(render partial: "index", locals: {qs: @qs}) %>')