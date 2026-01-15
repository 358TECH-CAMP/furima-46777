class Item < ApplicationRecord
  belongs_to :user
  has_one :order # Itemモデルにorderとのアソシエーションを追加しNoMethodErrorを解消
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  # READMEの記述に基づき、ActiveHashとの関連付けを定義
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  # バリデーション：空の投稿を保存できないようにする
  # カラム名を info, sales_status_id, shipping_fee_status_id に修正しました
  validates :image, :name, :info, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,
            :price, presence: true

  # 各プルダウンの選択が「---（id: 1）」の時は保存できないように設定
  validates :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,
            numericality: { other_than: 1, message: "can't be blank" }

  # 価格のバリデーション：範囲（300〜9,999,999）と数値（整数）のみ許可
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
