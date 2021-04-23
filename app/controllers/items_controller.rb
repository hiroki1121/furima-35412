class ItemsController < ApplicationController
  def index
    @item = Item.create
    @items = Item.all
  end

  def new
    @item = Item.new
    if user_signed_in?
      render new_item_path
    else
      redirect_to root_path
    end
  end

  def create
    @item = Item.create(items_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def items_params
    params.require(:item).permit(
      :image, :product_name, :description, :category_id,
      :product_status_id, :shipping_id, :prefecture_id,
      :delivery_day_id, :price
    ).merge(user_id: current_user.id)
  end
end
