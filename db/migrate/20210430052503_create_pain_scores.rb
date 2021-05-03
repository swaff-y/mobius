class CreatePainScores < ActiveRecord::Migration[6.1]
  def change
    create_table :pain_scores do |t|
      t.integer :day
      t.integer :patient
      t.integer :procedure
      t.integer :score

      t.timestamps
    end
  end
end
