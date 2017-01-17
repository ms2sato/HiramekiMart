class AddStatusToItems < ActiveRecord::Migration
  def change
    add_column :items, :status, :integer, null: false, default: 0
  end
end
