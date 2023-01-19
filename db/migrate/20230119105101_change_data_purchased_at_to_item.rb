class ChangeDataPurchasedAtToItem < ActiveRecord::Migration[6.1]
  def change
     change_column :items, :purchased_at, :date
  end
end
