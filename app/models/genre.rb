class Genre < ApplicationRecord
  # 商品に対して1対多となるようにアソシエーションを記述
  has_many :items, dependent: :destroy
  belongs_to :customer
  
  # バリデーション
  validates :name, presence: true
end
