class User

  initializePage: () ->
    #view.panelUtil.initToggleCollapseSwapIcon $("#searchPanel")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='user']")

view.user = new User