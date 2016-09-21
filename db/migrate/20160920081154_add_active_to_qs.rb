class AddActiveToQs < ActiveRecord::Migration
  def change
    add_column :qs, :active, :boolean
  end
end
