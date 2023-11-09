class Address < ApplicationRecord
  has_one :inn

  validates :street, :postal_code, presence: true
end
