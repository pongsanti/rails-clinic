class view.RemoteContent

  constructor: (@placeholder_data_attributes) ->

  fetchAjaxContent: ()->
    placeholder = view.util.findElemByDataAttributes(@placeholder_data_attributes)
    if placeholder.length
      @triggerAnchorClick(placeholder)

  triggerAnchorClick: (placeholder)->
    anchor = view.util.findAnchorWithDataAttribute({"refresh": "true"}, placeholder)
    if anchor.length
      anchor.trigger("click.rails")