class OrderDelivery
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipality, :address, :building_name, :phone_num, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A\d{7}\z/ }
    validates :prefecture_id
    validates :municipality
    validates :address
    validates :phone_num, format: { with: /\A\d{10,11}\z/ }
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivery.create(
      post_code: post_code,
      prefecture_id: prefecture_id,
      municipality: municipality,
      address: address,
      building_name: building_name,
      phone_num: phone_num,
      order_id: order.id
    )
  end
end
