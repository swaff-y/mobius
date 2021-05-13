class RemoveClinicIdFromTeamMembers < ActiveRecord::Migration[6.1]
  def change
    remove_column :team_members, :clinic_id, :integer
  end
end
