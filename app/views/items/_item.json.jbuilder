json.extract! item, :id, :user_id, :name, :image, :description, :target_price, :limited_at, :created_at, :updated_at
json.url item_url(item, format: :json)