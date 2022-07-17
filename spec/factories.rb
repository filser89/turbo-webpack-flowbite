FactoryBot.define do

  factory :user do
    sequence(:email) { |n| "email#{n}@email.com" }
    password { '123456' }
  end

  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    quantity { 10 }
  end

  factory :order do
    user
    product
  end
end
