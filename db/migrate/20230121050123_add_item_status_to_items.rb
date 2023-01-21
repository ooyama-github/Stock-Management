class AddItemStatusToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :item_status, :integer, null: false, default:0
  end
end
