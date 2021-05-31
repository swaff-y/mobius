class Patient < ApplicationRecord
  has_and_belongs_to_many :clinics
  has_many :pain_scores
  has_many :procedures
  belongs_to :user, optional: true
end
