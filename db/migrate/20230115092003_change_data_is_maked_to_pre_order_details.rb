class ChangeDataIsMakedToPreOrderDetails < ActiveRecord::Migration[6.1]
  def change
    change_column :pre_order_details, :is_maked, :boolean
  end
end
