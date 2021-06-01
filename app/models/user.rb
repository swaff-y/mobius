class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_and_belongs_to_many :clinics
  has_many :patients
end
