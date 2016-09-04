class Qs

  placeholder_data_attributes:
    controller: "qs"
    action: "index"

  reloadTimeout: 10000
  timeoutLoop: null

  fetchAjaxContent: ()->
    placeholder = view.util.findElemByDataAttributes(@placeholder_data_attributes)
    if placeholder.length
      @triggerAnchorClick(placeholder)
    else
      if view.qs.timeoutLoop?
        clearTimeout(view.qs.timeoutLoop)

  triggerAnchorClick: (placeholder) ->
    view.qs.showLoadingIcon(true)

    clearTimeout(view.qs.timeoutLoop)
    anchor = view.util.findAnchorWithDataAttribute({"refresh": "true"}, placeholder)
    if anchor.length
      anchor.trigger("click.rails")
      view.qs.timeoutLoop = setTimeout(view.qs.triggerAnchorClick.bind(null, placeholder), view.qs.reloadTimeout)

  showLoadingIcon: (show) ->
    elem = view.util.findElemByDataAttributes {"loading-icon": "true"}
    if elem
      if show
        elem.show();
      else
        elem.hide();

view.qs = new Qs