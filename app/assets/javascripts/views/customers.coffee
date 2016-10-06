# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class window.view.typeahead
  constructor: (@args)->

  initialize:()->
    if @args.txt_input.length and @args.url and @args.url.length > 0

      entries = new Bloodhound(
        datumTokenizer: Bloodhound.tokenizers.whitespace
        queryTokenizer: Bloodhound.tokenizers.whitespace
        prefetch: 
          url: @args.url
          cache: false
      )

      @args.txt_input.typeahead(
        {
          hint: true,
          highlight: true,
        },  
        { 
          name: 'entries',
          source: entries
        }
      )

class Customer

  subDistrictSuggestion : null
  districtSuggestion : null
  provinceSuggestion : null

  displayThaiYear: () ->
    $('select#customer_birthdate_1i option').each(
      (index, value) ->
        option = $(value)
        year = parseInt(option.text())
        option.text(year + ' (' + String(year + 543) + ')')
    )

  displayMonthNumber: () ->
    $('select#customer_birthdate_2i option').each(
      (index, value) ->
        option = $(value)
        option.text(option.text() + ' (' + String(index + 1) + ')');
    )

  preSelectSex: () ->
    $('input[type=radio]:checked').parent().button("toggle")


  initializePage: () ->
    @displayThaiYear()
    @displayMonthNumber()
    @preSelectSex()
    @initializeTypeaheads()
    view.panelUtil.initToggleCollapseSwapIcon $("#searchPanel")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='customer']")

  initializePrefixSelectSex: ()->
    prefix_select = $("select[id*='customer_prefix']")

    prefix_select.change (evt) =>
      sex_selected_value = prefix_select.find("option:selected").data("sex")
      $("\##{sex_selected_value}_btn").button("toggle")

  initializeTypeaheads: ()->
    delete @provinceSuggestion
    @provinceSuggestion = @initializeTypeahead('customer_province', '/provinces')

    delete @districtSuggestion
    @districtSuggestion = @initializeTypeahead('customer_district', '/districts')

    delete @subDistrictSuggestion
    @subDistrictSuggestion = @initializeTypeahead('customer_sub_district', '/sub_districts')

  initializeTypeahead: (id, url) ->
    obj = new view.typeahead(
      txt_input: $("input[id='#{id}']"),
      url: "#{url}"
    )
    obj.initialize()
    return obj

view.customer = new Customer