class Inn < ApplicationRecord
  has_one :address
  accepts_nested_attributes_for :address
  belongs_to :user

  # accepts_nested_attributes_for :address

  # has_and_belongs_to_many :payment_methods
  # accepts_nested_attributes_for :payment_methods
end
