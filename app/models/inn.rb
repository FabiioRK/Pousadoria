class Inn < ApplicationRecord
  enum payment_method: {
    cash: 0,
    credit_card: 1,
    debit_card: 2
  }
  belongs_to :address
  belongs_to :user
end
