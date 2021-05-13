class AddStatusToClinics < ActiveRecord::Migration[6.1]
  def change
    add_column :clinics, :status, :text
  end
end
