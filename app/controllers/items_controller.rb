class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :restrictions_on_edit, only: [:edit]

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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
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

  def restrictions_on_edit
    @item = Item.find(params[:id])
    @user = User.find(@item.id)
    redirect_to new_user_registration_path unless user_signed_in?
    redirect_to root_path if user_signed_in? && current_user.id != @user.id
  end
end
