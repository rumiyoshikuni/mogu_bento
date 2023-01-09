class AddColumnsTopreOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :pre_order_details, :pre_orders_id, :integer, :null => false
    add_column :pre_order_details, :item_id, :integer, :null => false
    add_column :pre_order_details, :quantity, :integer, :null => false
    add_column :pre_order_details, :status, :integer, :null => false
    add_column :pre_order_details, :tax_price, :integer, :null => false
  end
end
