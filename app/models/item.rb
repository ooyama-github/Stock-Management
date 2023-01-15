class Item < ApplicationRecord
  belongs_to :genre
  belongs_to :customer
  has_one_attached :image
  
  validates :Date_of_purchase, presence: true
  validates :name, presence: true
  validates :Purchase_amount, presence: true
  validates :Sale_amount, presence: true
  
  
  
# # ActiveStorageによるアイコン画像保存機能

# has_one_attached :illust_image
# # ユーザのアイコン画像アップロードに対してのバリデーション(.jpg .jpeg .pngのみ許可)
# validate :illust_image_type
# private
# def illust_image_type
#   if illust_image.blob
#   if !illust_image.blob.content_type.in?(%('image/jpeg image/jpg image/png'))
#     errors.add(:illust_image, 'はjpeg、jpgまたはpng形式でアップロードしてください')

#   end
#   end
# end
# end
end
