class CreateJoinTableClinicsTeamMembers < ActiveRecord::Migration[6.1]
  def change
    create_join_table :team_members, :clinics do |t|
      # t.index [:team_member_id, :clinic_id]
      # t.index [:clinic_id, :team_member_id]
    end
  end
end
