class Item < ApplicationRecord
  belongs_to :genre
  belongs_to :customer
  
  validates :purchased_at, presence: true
  validates :name, presence: true
  validates :purchase_amount, presence: true
  validates :sale_amount, presence: true
  
  
  
  # ActiveStorageによるアイコン画像保存機能
  has_one_attached :image
  # ユーザのアイコン画像アップロードに対してのバリデーション(.jpg .jpeg .pngのみ許可)
  validate :image_type
  private
  def image_type
    if image.blob
    if !image.blob.content_type.in?(%('image/jpeg image/jpg image/png'))
      errors.add(:image, 'はjpeg、jpgまたはpng形式でアップロードしてください')
    end
    end
  end

end
