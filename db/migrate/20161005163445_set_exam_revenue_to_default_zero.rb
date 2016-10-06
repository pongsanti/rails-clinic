class SetExamRevenueToDefaultZero < ActiveRecord::Migration
  def change
    change_column :exams, :revenue, :decimal, precision: 9, scale: 2, default: 0
  end
end
