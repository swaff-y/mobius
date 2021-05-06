class Clinic < ApplicationRecord
  has_and_belongs_to_many :team_members
  has_and_belongs_to_many :patients
  has_many :procedures
end
