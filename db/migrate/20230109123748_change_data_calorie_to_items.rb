class ChangeDataCalorieToItems < ActiveRecord::Migration[6.1]
  def change
    change_column :items, :calorie, :integer
  end
end
