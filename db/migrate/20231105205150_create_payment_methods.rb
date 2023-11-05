class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_methods do |t|
      t.integer :method, default: 0, null: false

      t.timestamps
    end
  end
end
