class AddActiveToInns < ActiveRecord::Migration[7.1]
  def change
    add_column :inns, :active, :boolean, default: true
  end
end
