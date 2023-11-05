class Inn < ApplicationRecord
  belongs_to :address
  belongs_to :user
  has_and_belongs_to_many :payment_methods
  accepts_nested_attributes_for :payment_methods
end
