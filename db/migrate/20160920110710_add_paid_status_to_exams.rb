class AddPaidStatusToExams < ActiveRecord::Migration
  def change
    add_column :exams, :paid_status, :boolean
  end
end
