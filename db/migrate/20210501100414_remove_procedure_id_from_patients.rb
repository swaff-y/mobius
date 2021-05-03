class RemoveProcedureIdFromPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :procedure_id, :integer
  end
end
