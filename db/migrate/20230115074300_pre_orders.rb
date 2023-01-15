class PreOrders < ActiveRecord::Migration[6.1]
  def change
    change_column_default :pre_orders, :is_active, from: false, to: true
  end
end
