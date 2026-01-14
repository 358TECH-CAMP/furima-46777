class ItemsController < ApplicationController
  # ログインしていない場合はログインページへリダイレクト
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :info, # ← description から info に修正しました
      :category_id,
      :sales_status_id,        # マイグレーションファイルの sales_status_id と合わせる
      :shipping_fee_status_id, # マイグレーションファイルの shipping_fee_status_id と合わせる
      :prefecture_id,
      :scheduled_delivery_id,
      :price
    ).merge(user_id: current_user.id)
  end
end
