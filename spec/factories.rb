FactoryBot.define do
  factory :table_builder do
    
  end

  factory :list_column do
    
  end


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
