class CreateClinics < ActiveRecord::Migration[6.1]
  def change
    create_table :clinics do |t|
      t.text :address
      t.text :name

      t.timestamps
    end
  end
end
