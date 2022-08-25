FactoryBot.define do
  factory :form_builder do
    
  end

  factory :form_field do
    
  end

  factory :list_paginator do
    
  end

  factory :list_filter do
    
  end

  factory :show_builder do
    
  end

  factory :admin_builder do
    
  end

  factory :list_builder do
    
  end

  factory :admin_resource do
    
  end

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
