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
    @selectBirthDateYear = new components.SelectBirthDate({id: "customer_birthdate_1i"})
    @selectBirthDateYear.setThaiYear()

  displayMonthNumber: () ->
    delete @selectBirthDateMonth
    @selectBirthDateMonth = new components.SelectBirthDate({id: "customer_birthdate_2i"})
    @selectBirthDateMonth.setThaiMonth()

  initializePage: () ->
    @displayThaiYear()
    @displayMonthNumber()
    @initializeTypeaheads()
    view.panelUtil.initToggleCollapseSwapIcon $("#searchPanel")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='customer']")

  initializePrefixSelectSex: ()->
    delete @selectPrefix
    @selectPrefix = new components.SelectPrefix({id: "customer_prefix"})
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
    obj = new components.typeahead(
      txt_input: $("input[id='#{id}']"),
      url: "#{url}"
    )
    obj.initialize()
    return obj

view.customer = new Customer