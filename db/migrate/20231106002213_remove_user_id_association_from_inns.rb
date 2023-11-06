class RemoveUserIdAssociationFromInns < ActiveRecord::Migration[7.1]
  def change
    remove_reference :inns, :user, null: false, foreign_key: true
  end
end
