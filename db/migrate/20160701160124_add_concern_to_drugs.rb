class AddConcernToDrugs < ActiveRecord::Migration
  def change
    add_column :drugs, :concern, :string
  end
end
