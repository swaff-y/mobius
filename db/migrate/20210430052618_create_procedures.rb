class CreateProcedures < ActiveRecord::Migration[6.1]
  def change
    create_table :procedures do |t|
      t.text :description
      t.text :name
      t.text :procedure_ID

      t.timestamps
    end
  end
end
