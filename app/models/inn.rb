class Inn < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number,
            :phone_number, :contact_email, :payment_methods, presence: true

  has_one :address
  accepts_nested_attributes_for :address
  belongs_to :user
  has_many :rooms

  serialize :payment_methods, JSON
end
