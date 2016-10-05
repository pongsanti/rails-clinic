class Client

  initializePage: () ->
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='client']")

view.client = new Client