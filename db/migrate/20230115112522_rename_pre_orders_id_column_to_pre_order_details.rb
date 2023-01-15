class RenamePreOrdersIdColumnToPreOrderDetails < ActiveRecord::Migration[6.1]
  def change
    rename_column :pre_order_details, :pre_orders_id, :pre_order_id
  end
end
