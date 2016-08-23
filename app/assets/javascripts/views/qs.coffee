class Qs

  controller: "qs"
  reloadTimeout: 10000
  timeoutLoop: null

  loadIndex: () ->
    view.qs.showLoadingIcon(true);

    clearTimeout(view.qs.timeoutLoop);
    $.get("/qs")
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