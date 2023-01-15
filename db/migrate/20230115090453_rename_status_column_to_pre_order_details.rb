class RenameStatusColumnToPreOrderDetails < ActiveRecord::Migration[6.1]
  def change
    rename_column :pre_order_details, :status, :is_maked
  end
end
