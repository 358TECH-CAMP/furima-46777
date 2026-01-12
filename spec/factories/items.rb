# spec/factories/items.rb
FactoryBot.define do
  factory :item do
    name                  { 'テスト商品' }
    description           { 'テスト用の商品説明' }
    price                 { 300 }
    category_id            { 1 }
    status_id              { 1 }
    delivery_fee_id        { 1 }
    prefecture_id          { 1 }
    scheduled_delivery_id  { 1 }

    association :user

    after(:build) do |item|
      item.image.attach(
        io: StringIO.new('test'),
        filename: 'test.png',
        content_type: 'image/png'
      )
    end
  end
end
