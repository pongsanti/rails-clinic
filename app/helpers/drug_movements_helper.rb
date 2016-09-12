module DrugMovementsHelper

  def bal_diff_class(drug_movement)
    (drug_movement.bal_diff < 0) ? "stock-out" : "stock-in"
  end
  
end