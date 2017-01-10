class AddCategoryToItems < ActiveRecord::Migration
  def change
    add_column :items, :category, :integer, null: false
  end
end
