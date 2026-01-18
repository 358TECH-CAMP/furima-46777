class AddRememberCreatedAtToUsers < ActiveRecord::Migration[7.1]
  def change
# usersテーブルに remember_created_at カラムがない場合のみ追加する
  unless column_exists?(:users, :remember_created_at)    
  add_column :users, :remember_created_at, :datetime
   end
 end
end