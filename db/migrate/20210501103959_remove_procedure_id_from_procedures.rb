class RemoveProcedureIdFromProcedures < ActiveRecord::Migration[6.1]
  def change
    remove_column :procedures, :procedure_ID, :text
  end
end
