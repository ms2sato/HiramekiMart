FactoryGirl.define do
  factory :item do
    user_id 123
    name "アイテム名"
    target_price 100
    limited_at Date.today
    user # ファクトリよびだし
  end
end
