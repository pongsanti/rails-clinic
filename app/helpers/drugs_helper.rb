module DrugsHelper

  def balance_with_unit(drug)
    "#{decimal(drug.balance)} #{drug.unit}"
  end

end