class Room < ApplicationRecord
  # validates :name, :dimension, :standard_price, presence: true
  # validacoes do room estao quebrando a aplicacao por algum motivo

  belongs_to :inn
  has_many :custom_prices
end
