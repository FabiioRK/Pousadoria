class PaymentMethod < ApplicationRecord
  enum method: {
    credit_card: 'Cartão de Crédito',
    debit_card: 'Cartão de Débito',
    cash: 'Dinheiro',
    pix: 'Pix'
  }
  has_and_belongs_to_many :inns
end
