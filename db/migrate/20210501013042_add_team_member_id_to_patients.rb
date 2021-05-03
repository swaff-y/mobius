class AddTeamMemberIdToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :team_member_id, :integer
  end
end
