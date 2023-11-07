class Address < ApplicationRecord
  has_one :inn

  validates :postal_code, presence: true
end
