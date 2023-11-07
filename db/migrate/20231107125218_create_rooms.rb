class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.integer :dimension
      t.integer :max_accommodation
      t.integer :standard_price
      t.boolean :has_bathroom
      t.boolean :has_balcony
      t.boolean :has_air_conditioner
      t.boolean :has_tv
      t.boolean :has_closet
      t.boolean :has_safe
      t.boolean :is_disabled_accessible
      t.references :inn, null: false, foreign_key: true

      t.timestamps
    end
  end
end
