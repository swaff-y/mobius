class PainScore < ApplicationRecord
  belongs_to :patient, optional: true
  belongs_to :procedure, optional: true
end
