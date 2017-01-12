class AddCategoryToItems < ActiveRecord::Migration
  def up
    add_column :items, :category, :integer
    change_column :items, :category, :integer, null: false
  end

  def down
    remove_column :items, :category, :integer
  end
end
