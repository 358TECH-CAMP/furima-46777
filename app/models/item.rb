# app/models/item.rb
class Item < ApplicationRecord
  # ユーザーとの関連付け（出品者）
  belongs_to :user

  # ActiveStorageで画像を1枚添付
  has_one_attached :image

  # ActiveHashをActiveRecordと一緒に使うための設定
  extend ActiveHash::Associations::ActiveRecordExtensions

  # ActiveHashとの関連付け
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  # バリデーション（必須項目）
  validates :name, :description, :price, :image, presence: true

  # 「---（id:0）」が選択されていないことを確認
  validates :category_id, :status_id, :delivery_fee_id, :prefecture_id, :scheduled_delivery_id,
            numericality: { other_than: 0, message: "can't be blank" }

  # 価格のバリデーション
  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999
            }
end
