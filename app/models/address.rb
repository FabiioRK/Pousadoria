class Address < ApplicationRecord
  has_one :inn

  validates :street, :district, :city, :state, :postal_code, presence: true
end
