class User

  preSelectSex: () ->
    $('input[type=radio]:checked').parent().button("toggle")

  initializePage: () ->
    @preSelectSex()
    #view.panelUtil.initToggleCollapseSwapIcon $("#searchPanel")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='user']")

view.user = new User