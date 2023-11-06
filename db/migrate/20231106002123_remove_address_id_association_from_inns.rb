class RemoveAddressIdAssociationFromInns < ActiveRecord::Migration[7.1]
  def change
    remove_reference :inns, :address, null: false, foreign_key: true
  end
end
