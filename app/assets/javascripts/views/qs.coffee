class Qs

  controller: "qs"
  reloadTimeout: 10000
  timeoutLoop: null

  loadIndex: () ->
    placeholder = view.util.findDataDiv(view.qs.controller, "index")
    view.util.showLoadingIcon(placeholder)

    clearTimeout(view.qs.timeoutLoop);
    $.get("/qs")
    view.qs.timeoutLoop = setTimeout(view.qs.loadIndex, view.qs.reloadTimeout)

view.qs = new Qs