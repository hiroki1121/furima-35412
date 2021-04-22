class Item < ApplicationRecord
  with_options presence: true do
    validates :product_name
    validates :description
    validates :category_id
    validates :product_status_id
    validates :shipping_id
    validates :prefecture_id
    validates :delivery_day_id
    validates :price
  end

  belongs_to :user
end
