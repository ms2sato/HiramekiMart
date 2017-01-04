FactoryGirl.define do
  factory :favorite do
    sequence :user_id do |n|
      n
    end
    sequence :item_id do |n|
      n
    end
  end
end
