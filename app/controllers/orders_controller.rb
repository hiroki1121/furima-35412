class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_delivery = OrderDelivery.new
  end

  def new
  end

  def create
    @order_delivery = OrderDelivery.new(form_params)
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def form_params
    params.require(:order_delivery).permit(
      :post_code,
      :prefecture_id,
      :municipality,
      :address,
      :building_name,
      :phone_num,
      :item_id
    ).merge(
      user_id: current_user.id,
      token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: form_params[:price],
      card: form_params[:token],
      currency: 'jpy'
    )
  end
end
