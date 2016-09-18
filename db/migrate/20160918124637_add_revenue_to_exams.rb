class AddRevenueToExams < ActiveRecord::Migration
  def change
    add_column :exams, :revenue, :decimal, precision: 9, scale: 2
  end
end
