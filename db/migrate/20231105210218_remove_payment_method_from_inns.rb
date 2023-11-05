class RemovePaymentMethodFromInns < ActiveRecord::Migration[7.1]
  def change
    remove_column :inns, :payment_method
  end
end
