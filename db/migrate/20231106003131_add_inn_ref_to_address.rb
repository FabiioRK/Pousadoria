class AddInnRefToAddress < ActiveRecord::Migration[7.1]
  def change
    add_reference :addresses, :inn, null: false, foreign_key: true
  end
end
