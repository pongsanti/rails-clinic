class Qs

  controller: "qs"
  action: "index"
  url: "/qs"
  reloadTimeout: 10000
  timeoutLoop: null

  fetchAjaxContent: ()->
    placeholder = view.util.findElemPlaceholder(@controller, @action)
    if placeholder.length
      @loadIndex()
    else
      if view.qs.timeoutLoop
        clearTimeout(view.qs.timeoutLoop)

  loadIndex: () ->
    view.qs.showLoadingIcon(true)

    clearTimeout(view.qs.timeoutLoop)
    $.get(view.qs.url)
    view.qs.timeoutLoop = setTimeout(view.qs.loadIndex, view.qs.reloadTimeout)

  initRefreshBtn: () ->
    elem = view.util.findElementWithDataValue("refresh", "true")
    if elem
      elem.click(@loadIndex);

  showLoadingIcon: (show) ->
    elem = view.util.findElementWithDataValue("loading-icon", "true")
    if elem
      if show
        elem.show();
      else
        elem.hide();

view.qs = new Qs