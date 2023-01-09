class AddColumnsTocustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :last_name, :string, :null => false
    add_column :customers, :first_name, :string, :null => false
    add_column :customers, :last_name_kana, :string, :null => false
    add_column :customers, :first_name_kana, :string, :null => false
    add_column :customers, :tel_number, :integer, :null => false
    add_column :customers, :is_deleted, :boolean, default: false, null: false
  end
end
