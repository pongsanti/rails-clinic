class AddSexToPrefixes < ActiveRecord::Migration
  def change
    add_column :prefixes, :sex, :string
  end
end
