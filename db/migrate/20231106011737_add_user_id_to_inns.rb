class AddUserIdToInns < ActiveRecord::Migration[7.1]
  def change
    add_reference :inns, :user, null: false, foreign_key: true
  end
end
