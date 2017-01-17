FactoryGirl.define do
  factory :item do
    user_id 123
    name "アイテム名"
    target_price 100
    limited_at Date.today
    category 0
    support_course 1000
    status 0
    user # ファクトリよびだし
  end
end
