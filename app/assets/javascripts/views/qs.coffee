class Qs

  reloadTimeout: 20000
  progressBarId: '#qsProgressBar'
  timeoutLoop: null

  loadIndex: () ->
    clearTimeout(view.qs.timeoutLoop);
    $.get("/qs")
    view.qs.timeoutLoop = setTimeout(view.qs.loadIndex, view.qs.reloadTimeout)

view.qs = new Qs