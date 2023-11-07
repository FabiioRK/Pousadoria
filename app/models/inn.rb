class Inn < ApplicationRecord
  validates :brand_name, :payment_methods, presence: true

  has_one :address
  accepts_nested_attributes_for :address
  belongs_to :user
  has_many :rooms

  serialize :payment_methods, JSON
end
