placeholder = window.view.util.findDataDiv("qs", "index")
if placeholder
  view.util.fadeIn(placeholder, '<%= j(render partial: "index", locals: {qs: @qs}) %>');