class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :order

  with_options presence: true do
    validates :image
    validates :product_name
    validates :description
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :product_status_id
      validates :shipping_id
      validates :prefecture_id
      validates :delivery_day_id
    end
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_status
  belongs_to :shipping
  belongs_to :prefecture
  belongs_to :delivery_day
end
