FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    price { 1 }
    user { nil }
    category_id { 1 }
    status_id { 1 }
    delivery_fee_id { 1 }
    prefecture_id { 1 }
    scheduled_delivery_id { 1 }
  end
end
