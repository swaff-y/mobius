class CreateTeamMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :team_members do |t|
      t.text :email
      t.text :first_name
      t.text :last_name
      t.text :user

      t.timestamps
    end
  end
end
