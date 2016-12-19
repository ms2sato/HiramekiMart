FactoryGirl.define do
  factory :item do
    user_id 123
    name "アイテム名"
    target_price 100
    limited_at Date.today
  end

  factory :user do
    id 123
    name "ユーザ名"
    email "user@test.com"
    password "password"
    password_confirmation "password"
  end
end
