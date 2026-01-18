class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    # デプロイエラーを防ぐため、usersテーブルのマイグレーションにif_not_existsを追加）
   create_table :users, if_not_exists: true do |t|
      ## Custom columns
      t.string :nickname,           null: false
      t.string :last_name,          null: false
      t.string :first_name,         null: false
      t.string :last_name_kana,     null: false
      t.string :first_name_kana,    null: false
      t.date   :birth_date,         null: false

      ## Devise default
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.timestamps null: false
    end
  end
end
