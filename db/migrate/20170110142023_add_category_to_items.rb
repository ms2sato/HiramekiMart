class AddCategoryToItems < ActiveRecord::Migration
  def change
    add_column :items, :category, :integer, null: false, default: 4 
  end
end
