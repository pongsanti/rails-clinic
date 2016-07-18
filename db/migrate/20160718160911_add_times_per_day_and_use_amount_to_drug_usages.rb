class AddTimesPerDayAndUseAmountToDrugUsages < ActiveRecord::Migration
  def change
    add_column :drug_usages, :times_per_day, :integer
    add_column :drug_usages, :use_amount, :decimal, precision: 4, scale: 1
  end
end
