class AddDescriptionToItems < ActiveRecord::Migration[7.1]
  def change
    # itemsテーブルに description カラムがない場合のみ追加する
    unless column_exists?(:items, :description)
      add_column :items, :description, :text
    end
  end
end