class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    # @delivery = Delivery.new
  end

  def new
    @order = OrderDelivery.new(form_params)
  end

  def create
    @order = OrderDelivery.new(form_params)
    if @order.valid?
      @order.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      # @delivery = Delivery.new
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
    ).merge(user_id: current_user.id)
  end
end
