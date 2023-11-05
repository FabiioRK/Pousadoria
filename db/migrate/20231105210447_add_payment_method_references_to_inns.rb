class AddPaymentMethodReferencesToInns < ActiveRecord::Migration[7.1]
  def change
    add_reference :inns, :payment_method, null: false, foreign_key: true
  end
end
