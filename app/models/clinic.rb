class Clinic < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :patients
  has_many :procedures
end
