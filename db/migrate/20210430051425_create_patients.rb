class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.integer :clinic
      t.boolean :consent
      t.text :email
      t.text :first_name
      t.text :referring_clinician
      t.text :last_name
      t.text :mobile_number
      t.integer :procedure_id
      t.date :procedure_start_date
      t.text :program_status
      t.integer :team_member
      t.text :response_status
      t.boolean :return_patient

      t.timestamps
    end
  end
end
