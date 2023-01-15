class ChangeCloumnsNotnullAddPreOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :pre_orders, :is_active, :boolean, null: false
  end
end
