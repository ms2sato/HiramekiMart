FactoryGirl.define do
  factory :user do
    name "ユーザ名"
    email "user2@test.com"
    password "password"
    password_confirmation "password"
  end
end
