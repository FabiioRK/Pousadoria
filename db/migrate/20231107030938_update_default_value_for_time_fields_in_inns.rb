class UpdateDefaultValueForTimeFieldsInInns < ActiveRecord::Migration[7.1]
  def change
    change_column_default :inns, :checkin_time, '12:00:00'
    change_column_default :inns, :checkout_time, '14:00:00'
  end
end
