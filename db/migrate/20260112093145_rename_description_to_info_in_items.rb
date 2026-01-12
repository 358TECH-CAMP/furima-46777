class RenameDescriptionToInfoInItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :items, :description, :info
  end
end
