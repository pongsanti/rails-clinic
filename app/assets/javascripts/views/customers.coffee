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

  streetSuggestion: null
  subDistrictSuggestion : null
  districtSuggestion : null
  provinceSuggestion : null

  selectPrefix: null
  selectBirthDateYear: null
  selectBirthDateMonth: null

  displayThaiYear: () ->
    delete @selectBirthDateYear
    @selectBirthDateYear = new window.components.SelectBirthDate({id: "customer_birthdate_1i"})
    @selectBirthDateYear.setThaiYear()

  displayMonthNumber: () ->
    delete @selectBirthDateMonth
    @selectBirthDateMonth = new window.components.SelectBirthDate({id: "customer_birthdate_2i"})
    @selectBirthDateMonth.setThaiMonth()

  initializePage: () ->
    @displayThaiYear()
    @displayMonthNumber()
    @initializeTypeaheads()
    view.panelUtil.initToggleCollapseSwapIcon $("#searchPanel")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='customer']")

  initializePrefixSelectSex: ()->
    delete @selectPrefix
    @selectPrefix = new window.components.SelectPrefix({id: "customer_prefix"})
    @selectPrefix.toggleSexButton()
    @selectPrefix.setupChange()

  initializeTypeaheads: ()->
    delete @provinceSuggestion
    @provinceSuggestion = @initializeTypeahead("customer_province", "/provinces")

    delete @districtSuggestion
    @districtSuggestion = @initializeTypeahead("customer_district", "/districts")

    delete @subDistrictSuggestion
    @subDistrictSuggestion = @initializeTypeahead("customer_sub_district", "/sub_districts")

    delete @streetSuggestion
    @streetSuggestion = @initializeTypeahead("customer_street", "/streets")

  initializeTypeahead: (id, url) ->
    obj = new view.typeahead(
      txt_input: $("input[id='#{id}']"),
      url: "#{url}"
    )
    obj.initialize()
    return obj

view.customer = new Customer