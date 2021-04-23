class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  with_options presence: true do
    validates :image
    validates :product_name
    validates :description
    validates :category_id, numericality: { other_than: 1 }
    validates :product_status_id, numericality: { other_than: 1 }
    validates :shipping_id, numericality: { other_than: 1 }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :delivery_day_id, numericality: { other_than: 1 }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_status
  belongs_to :shipping
  belongs_to :prefecture
  belongs_to :delivery_day
end
