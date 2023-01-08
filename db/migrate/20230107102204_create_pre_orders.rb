class CreatePreOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :pre_orders do |t|

      t.timestamps
    end
  end
end
