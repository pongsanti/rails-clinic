class User

  initializePage: () ->
    view.panelUtil.initToggleCollapseSwapIcon $("#searchPanel")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='user']")

view.admin.user = new User