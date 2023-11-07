class Inn < ApplicationRecord
  validates :brand_name, :payment_methods, presence: true

  has_one :address
  accepts_nested_attributes_for :address
  belongs_to :user

  serialize :payment_methods, JSON
  has_and_belongs_to_many :selected_payment_methods, class_name: 'PaymentMethod'
end
