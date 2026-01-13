class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  # 空の投稿を保存できないようにする（バリデーション）
  # info ではなく description に修正しています
  validates :image, :name, :description, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :scheduled_delivery_id,
            :price, presence: true

  # 各プルダウンの選択が「---（id: 1）」の時は保存できないようにする
  validates :category_id, :status_id, :delivery_fee_id, :prefecture_id, :scheduled_delivery_id,
            numericality: { other_than: 1, message: "can't be blank" }

  # 価格の範囲と数値のみを許可する設定
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
