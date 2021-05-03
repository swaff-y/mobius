class RemovePatientFromPainScores < ActiveRecord::Migration[6.1]
  def change
    remove_column :pain_scores, :patient, :integer
  end
end
