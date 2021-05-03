class AddClinicIdToProcedures < ActiveRecord::Migration[6.1]
  def change
    add_column :procedures, :clinic_id, :integer
  end
end
