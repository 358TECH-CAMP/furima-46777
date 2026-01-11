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
end
