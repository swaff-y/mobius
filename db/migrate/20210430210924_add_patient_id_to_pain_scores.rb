class AddPatientIdToPainScores < ActiveRecord::Migration[6.1]
  def change
    add_column :pain_scores, :patient_id, :integer
  end
end
