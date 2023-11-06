class RemovePaymentMethodReferenceFromInns < ActiveRecord::Migration[7.1]
  def change
    remove_reference :inns, :payment_method, null: false, foreign_key: true
  end
end
