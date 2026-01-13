FactoryBot.define do
  factory :item do
    name                  { 'テスト商品' }
    description           { 'テスト用の商品説明' } # info から description に修正
    price                 { 300 }
    category_id           { 2 }                # 1 から 2 に修正
    status_id             { 2 }                # 1 から 2 に修正
    delivery_fee_id       { 2 }                # 1 から 2 に修正
    prefecture_id         { 2 }                # 1 から 2 に修正
    scheduled_delivery_id { 2 }                # 1 から 2 に修正

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
