class Account < ApplicationRecord
  validates :name, uniqueness: true
  validates :token, uniqueness: true

  has_secure_token :token
end
