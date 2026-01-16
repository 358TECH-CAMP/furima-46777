class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string     :postal_code,   null: false
      t.integer    :prefecture_id, null: false
      t.string     :city,          null: false
      t.string     :house_number,  null: false  # 設計図の「address」に対応
      t.string     :building_name               # 設計図の「building」に対応
      t.string     :phone_number,  null: false
      t.references :order,         null: false, foreign_key: true
      t.timestamps
    end
  end
end