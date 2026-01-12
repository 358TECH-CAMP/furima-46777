class Item < ApplicationRecord
  # ActiveStorageで画像を1枚添付
  has_one_attached :image

  # ActiveHashとの紐付け
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  # バリデーション
  validates :name, :description, :price, :image, presence: true
  validates :category_id, :status_id, :delivery_fee_id, :prefecture_id, :scheduled_delivery_id,
            numericality: { other_than: 0, message: "can't be blank" }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
