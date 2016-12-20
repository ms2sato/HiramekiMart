FactoryGirl.define do
  factory :user do
    name "ユーザ名"
    sequence :email do |n|
      "user#{n}@test.com"
    end
    password "password"
    password_confirmation "password"
  end
end
