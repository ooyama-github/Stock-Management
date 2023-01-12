class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      # 商品のカラムを下記に実装
      t.integer :genre_id, foreign_key: true, null: false
      t.integer :quantity, null: false
      t.integer :Purchase_amount, null: false
      t.integer :Sale_amount, null: false
      t.string :Date_of_purchase, null: false
      t.text :memo


      t.timestamps
    end
  end
end
