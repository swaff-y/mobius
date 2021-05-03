class RemoveTeamMemberFromPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :team_member, :integer
  end
end
