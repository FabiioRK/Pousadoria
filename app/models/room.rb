class Room < ApplicationRecord
  validates :name, :dimension, :standard_price, presence: true

  belongs_to :inn
  has_many :custom_prices
end
