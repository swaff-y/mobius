class AddStatusToTeamMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :team_members, :status, :text
  end
end
