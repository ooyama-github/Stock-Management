class ChangePurchaseAmountAtToItems < ActiveRecord::Migration[6.1]
  def change
    rename_column :items, :Purchase_amount, :purchase_amount
    rename_column :items, :Sale_amount, :sale_amount
  end
end
