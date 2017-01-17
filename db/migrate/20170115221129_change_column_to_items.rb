class ChangeColumnToItems < ActiveRecord::Migration
  def change
    change_column :items, :target_price, :integer, null: false, default: 0
  end
end
