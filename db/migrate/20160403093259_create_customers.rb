class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :cn, null: false
      t.string :prefix
      t.string :name
      t.string :surname
      t.string :sex
      t.string :id_card_no
      t.string :passport_no
      t.date :birthdate
      t.string :address
      t.string :sub_district
      t.string :district
      t.string :province
      t.string :postal_code
      t.string :occupation
      t.string :tel_no

      t.timestamps null: false
    end
  end
end
