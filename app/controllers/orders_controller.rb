class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order = OrderDelivery.new
  end

  def new
    @order = OrderDelivery.new(form_params)
  end
  
  def create
    @order = OrderDelivery.new(form_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end
  
  private
  
  def form_params
    params.permit(
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
