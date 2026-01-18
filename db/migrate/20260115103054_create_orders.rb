class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    # if_not_exists: true を追加します
    create_table :orders, if_not_exists: true do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.timestamps
    end
  end
end