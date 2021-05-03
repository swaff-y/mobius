class RemoveProcedureFromPainScores < ActiveRecord::Migration[6.1]
  def change
    remove_column :pain_scores, :procedure, :integer
  end
end
