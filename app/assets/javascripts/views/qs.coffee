class Qs

  placeholder_data_attributes:
    controller: "qs"
    action: "index"

  reloadTimeout: 10000
  timeoutLoop: null

  fetchAjaxContent: ()->
    placeholder = view.util.findElemByDataAttributes(@placeholder_data_attributes)
    if placeholder.length
      @loadIndex(placeholder)
    else
      if view.qs.timeoutLoop?
        clearTimeout(view.qs.timeoutLoop)

  loadIndex: (placeholder) ->
    view.qs.showLoadingIcon(true)

    clearTimeout(view.qs.timeoutLoop)
    anchor = placeholder.find("a")
    if anchor.length
      anchor.trigger("click.rails")
      view.qs.timeoutLoop = setTimeout(view.qs.loadIndex.bind(null, placeholder), view.qs.reloadTimeout)

  showLoadingIcon: (show) ->
    elem = view.util.findElementWithDataValue("loading-icon", "true")
    if elem
      if show
        elem.show();
      else
        elem.hide();

view.qs = new Qs