class CreatePreOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :pre_order_details do |t|

      t.timestamps
    end
  end
end
