class RenameDateOfPurchaseToPurchasedAt < ActiveRecord::Migration[6.1]
  def change
    rename_column :items, :Date_of_purchase, :purchased_at
  end
end
