class ChangeAccountTypeToIntegerInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :account_type, :integer
  end
end
