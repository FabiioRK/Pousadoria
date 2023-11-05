class PaymentMethod < ApplicationRecord
  enum method: {
    cash: 0,
    credit_card: 1,
    debit_card: 2,
    pix: 3,
  }
end
