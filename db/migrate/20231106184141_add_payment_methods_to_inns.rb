class AddPaymentMethodsToInns < ActiveRecord::Migration[7.1]
  def change
    add_column :inns, :payment_methods, :string
  end
end
