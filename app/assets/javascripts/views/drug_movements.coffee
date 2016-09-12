class DrugMovement

  initializePage: () ->
    view.panelUtil.initToggleCollapseSwapIcon $("#searchPanel")
    view.panelUtil.initToggleCollapseSwapIcon $("div[id*='drugMovement']")

view.drug_movement = new DrugMovement