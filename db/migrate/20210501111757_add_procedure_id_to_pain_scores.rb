class AddProcedureIdToPainScores < ActiveRecord::Migration[6.1]
  def change
    add_column :pain_scores, :procedure_id, :integer
  end
end
