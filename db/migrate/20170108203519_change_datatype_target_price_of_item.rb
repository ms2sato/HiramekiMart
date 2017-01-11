class ChangeDatatypeTargetPriceOfItem < ActiveRecord::Migration
  def change
     change_column :items, :target_price, 'integer USING CAST(target_price AS integer)'
  end
end
