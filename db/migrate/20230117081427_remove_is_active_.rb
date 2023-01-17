class RemoveIsActive < ActiveRecord::Migration[6.1]
  def change
    remove_column :pre_orders, :is_active, :boolean
  end
end
