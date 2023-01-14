class Item < ApplicationRecord
  belongs_to :genre
  belongs_to :customer
  has_one_attached :image

  validates :Date_of_purchase, presence: true
  validates :name, presence: true
  validates :Purchase_amount, presence: true
  validates :Sale_amount, presence: true
end
