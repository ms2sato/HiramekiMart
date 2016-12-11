class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user_id, null: false
      t.string :name
      t.string :image
      t.text :description
      t.integer :target_price
      t.date :limited_at

      t.timestamps null: false
    end
  end
end
