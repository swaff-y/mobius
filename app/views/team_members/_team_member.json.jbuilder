json.extract! team_member, :id, :email, :first_name, :last_name, :user, :created_at, :updated_at
json.url team_member_url(team_member, format: :json)
