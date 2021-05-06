class TeamMember < ApplicationRecord
  has_and_belongs_to_many :clinics
  has_many :patients
end
