class Customer < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :genres, dependent: :destroy

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
