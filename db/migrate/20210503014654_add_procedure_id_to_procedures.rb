class AddProcedureIdToProcedures < ActiveRecord::Migration[6.1]
  def change
    add_column :procedures, :procedure_ID, :text
  end
end
