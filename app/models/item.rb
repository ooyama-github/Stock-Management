class Item < ApplicationRecord
  # アソシエーション
  belongs_to :genre
  belongs_to :customer
  
  # バリデーション
  validates :purchased_at, presence: true
  validates :name, presence: true
  validates :purchase_amount, presence: true
  validates :sale_amount, presence: true


  # 販売ステータス表記(enum)
  enum item_status: {
    "before_exhibition":0, "exhibit":1, "waiting_for_payment":2, "shipping_preparation":3, "waiting_for_evaluation":4, "sold":5
  }
  
  # 取引完了の合計金額を表示
  def self.get_sales_total(current_customer)
    Item.where(customer_id: current_customer.id, item_status: 5)
  end

  # ActiveStorageによるアイコン画像保存機能
  has_one_attached :image
  
  # 画像のバリデーション
  validate :image_type
  
  
  # 一週間の投稿データ取得
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } 
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } 
  scope :created_2days, -> { where(created_at: 2.days.ago.all_day) } 
  scope :created_3days, -> { where(created_at: 3.days.ago.all_day) } 
  scope :created_4days, -> { where(created_at: 4.days.ago.all_day) } 
  scope :created_5days, -> { where(created_at: 5.days.ago.all_day) } 
  scope :created_6days, -> { where(created_at: 6.days.ago.all_day) }
  
  # ユーザのアイコン画像アップロードに対してのバリデーション(.jpg .jpeg .pngのみ許可)
  private
  def image_type
    if image.blob
    if !image.blob.content_type.in?(%('image/jpeg image/jpg image/png'))
      errors.add(:image, 'はjpeg、jpgまたはpng形式でアップロードしてください')
    end
    end
  end

end
