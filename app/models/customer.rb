class Customer < ApplicationRecord
  # アソシエーション
  has_many :items, dependent: :destroy
  has_many :genres, dependent: :destroy
  
   # ActiveStorageによるアイコン画像保存機能
  has_one_attached :profile_image
  # プロフィール画像を取得するためのメソッド
  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/icon.png')
      profile_image.attach(io: File.open(file_path),filename: 'default-image.png',content_type:'image/png')
    end
    profile_image.variant(gravity: :center, resize:"#{width}x#{height}^", crop:"#{width}x#{height}+0+0").processed
  end

  # ゲストログイン用の記述
  def self.guest
   find_or_create_by!(name: 'ゲストユーザー' ,email: 'guestuser@example.com') do |customer|
     customer.password = SecureRandom.urlsafe_base64
     customer.name = "ゲストユーザー"
   end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
