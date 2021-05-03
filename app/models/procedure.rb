class Procedure < ApplicationRecord
  belongs_to :clinic, optional: true
  has_many :pain_scores
  belongs_to :patient, optional: true
end
