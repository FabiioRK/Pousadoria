class CreateInns < ActiveRecord::Migration[7.1]
  def change
    create_table :inns do |t|
      t.string :corporate_name
      t.string :brand_name
      t.string :registration_number
      t.string :phone_number
      t.string :contact_email
      t.boolean :pet_allowed
      t.integer :payment_method
      t.time :checkin_time
      t.time :checkout_time
      t.text :description
      t.text :usage_policies
      t.references :address, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
