class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
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
