class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :restrictions_on_edit, only: [:edit, :update]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(items_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(items_params)
      redirect_to item_path
    else
      render :edit
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

  def set_item
    @item = Item.find(params[:id])
  end

  def restrictions_on_edit
    redirect_to root_path if current_user.id != @item.user.id
  end
end
