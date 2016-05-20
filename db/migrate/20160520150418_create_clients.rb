class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.text :description
      t.string :display_name
      t.string :owner_name
      t.string :owner_surname
      t.string :email
      t.string :address
      t.string :sub_district
      t.string :district
      t.string :province
      t.string :postal_code
      t.string :home_phone_no
      t.string :mobile_phone_no

      t.timestamps null: false
    end
  end
end
