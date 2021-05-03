class AddPatientIdToProcedures < ActiveRecord::Migration[6.1]
  def change
    add_column :procedures, :patient_id, :integer
  end
end
