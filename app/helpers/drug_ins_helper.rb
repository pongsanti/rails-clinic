module DrugInsHelper

  def index_balance_tab_head(drug)
    "#{DrugIn.human_attribute_name(:balance)} (#{drug.unit})"
  end

end