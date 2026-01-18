class CreateItems < ActiveRecord::Migration[7.0] # ← ここが CreateItems である必要がありますdef change
  def change
     # if_not_exists: true を追加
    create_table :items, if_not_exists: true do |t|
    t.string     :name,                   null: false
    t.text       :info,                   null: false # ここを設計書通りの「info」にする
    t.integer    :category_id,            null: false
    t.integer    :sales_status_id,        null: false # 設計書通りの「sales_status_id」
    t.integer    :shipping_fee_status_id, null: false # 設計書通りの「shipping_fee_status_id」
    t.integer    :prefecture_id,          null: false
    t.integer    :scheduled_delivery_id,  null: false
    t.integer    :price,                  null: false
    t.references :user,                   null: false, foreign_key: true
    t.timestamps
     end
  end
end