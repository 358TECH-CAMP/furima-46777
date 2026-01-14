FactoryBot.define do
  factory :item do
    name                   { 'テスト商品' }
    info                   { 'テスト用の商品説明' } # descriptionから変更
    category_id            { 2 }
    sales_status_id        { 2 }                 # status_idから変更
    shipping_fee_status_id { 2 }                 # delivery_fee_idから変更
    prefecture_id          { 2 }
    scheduled_delivery_id  { 2 }
    price                  { 300 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
