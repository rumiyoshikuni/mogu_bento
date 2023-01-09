class AddColumnsTopreOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :pre_orders, :customer_id, :integer, :null => false
    add_column :pre_orders, :total_payment, :integer, :null => false
    add_column :pre_orders, :is_active, :boolean, default: false, null: true
    add_column :pre_orders, :receiving_date, :date, :null => false
    add_column :pre_orders, :receiving_time, :time, :null => false
    add_column :pre_orders, :demand, :text, :null => false
  end
end
