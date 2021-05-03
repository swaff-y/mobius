class CreateJoinTableClinicsPatients < ActiveRecord::Migration[6.1]
  def change
    create_join_table :clinics, :patients do |t|
    end
  end
end
