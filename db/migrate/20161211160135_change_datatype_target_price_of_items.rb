class ChangeDatatypeTargetPriceOfItems < ActiveRecord::Migration
  def change
    change_column :items, :target_price, :text
  end
end
