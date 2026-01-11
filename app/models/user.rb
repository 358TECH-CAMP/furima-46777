class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         #  :rememberable,
         :validatable

  validates :nickname, presence: true
  validates :birth_date, presence: true

  validates :first_name, :last_name,
            presence: true,
            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }

  validates :first_name_kana, :last_name_kana,
            presence: true,
            format: { with: /\A[ァ-ヶー]+\z/ }
  # パスワードの英数字混合チェック
  validates :password,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
                      message: 'は英字と数字の両方を含めてください' },
            if: -> { password.present? }
end
