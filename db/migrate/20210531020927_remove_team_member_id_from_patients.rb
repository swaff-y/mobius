class RemoveTeamMemberIdFromPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :team_member_id, :integer
  end
end
