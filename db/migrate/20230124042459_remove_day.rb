class RemoveDay < ActiveRecord::Migration[6.1]
  def change
    remove_column :pre_orders, :day, :date
  end
end
