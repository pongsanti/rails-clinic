class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.date :date
      t.time :time
      t.references :exam, index: true, foreign_key: true
      t.string :note

      t.timestamps null: false
    end
  end
end
