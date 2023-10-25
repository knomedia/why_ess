class Business < ApplicationRecord

  validates :uuid, uniqueness: true
  validates :listing, presence: true, if: proc { listing.nil? }

end
