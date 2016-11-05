class window.components.Select
  constructor: (@args)->

  id: ()->
    @args['id'] if @args?

  get: ()->
    $("select[id*='#{@id()}']")

  find: (query)->
    @get().find(query)

  options: ()->
    @find("option")

class window.components.SelectBirthDate extends window.components.Select
  setThaiYear:() ->
    @options().each (index, value)->
      option = $(value)
      year = parseInt(option.text())
      option.text(year + ' (' + String(year + 543) + ')')

  setThaiMonth:()->
    @options().each (index, value)->
      option = $(value)
      option.text(option.text() + ' (' + String(index + 1) + ')')


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