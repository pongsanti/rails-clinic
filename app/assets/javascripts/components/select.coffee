class window.components.Select
  constructor: (@args)->

  id: ()->
    @args['id'] if @args?

  get: ()->
    $("select[id*='#{@id()}']")

  find: (query)->
    @get().find(query)

class window.components.SelectPrefix extends window.components.Select
  
  sexSelected:()->
    @find("option:selected").data("sex")

  setupChange: ()->
    @get().change (evt) =>
      @toggleSexButton()

  button: (id)->
    $("\##{id}_btn")

  toggleSexButton: ()->
    @button(@sexSelected()).button("toggle")