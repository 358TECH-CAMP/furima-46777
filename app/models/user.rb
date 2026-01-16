# app/models/user.rb
class User < ApplicationRecord
  # Deviseモジュール
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         # :rememberable,
         :validatable
  # アソシエーションを追加
  has_many :items    # ユーザーは複数の商品を出品できる
  has_many :orders   # ユーザーは複数の商品を購入できる
  # ニックネーム
  validates :nickname, presence: { message: 'を入力してください' }

  # 生年月日
  validates :birth_date, presence: { message: 'を入力してください' }

  # 名前（全角）
  validates :first_name, presence: { message: 'を入力してください' },
                         format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字を使用してください' }
  validates :last_name, presence: { message: 'を入力してください' },
                        format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字を使用してください' }

  # 名前（カナ）
  validates :first_name_kana, presence: { message: 'を入力してください' },
                              format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナを使用してください' }
  validates :last_name_kana, presence: { message: 'を入力してください' },
                             format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナを使用してください' }

  # email
  validates :email, presence: { message: 'を入力してください' },
                    uniqueness: { message: 'はすでに存在します' },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'は不正な値です' }

  # password（英数字混合・6文字以上）
  validates :password, presence: { message: 'を入力してください' },
                       length: { minimum: 6, message: 'は6文字以上で入力してください' },
                       format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'は英字と数字の両方を含めてください' },
                       confirmation: { message: 'とPasswordが一致しません' }
end
