class TeamMember < ApplicationRecord
  belongs_to :clinic, optional:true
  has_many :patients
end
