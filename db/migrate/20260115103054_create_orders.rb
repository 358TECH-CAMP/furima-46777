class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      # 以下の2行を必ず含めてください
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.timestamps
    end
  end
end