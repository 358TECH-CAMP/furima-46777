class ItemsController < ApplicationController
  # ログインしていない場合はログインページへリダイレクト
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  # 出品者でないならトップページへ戻す
  before_action :move_to_index, only: [:edit, :update]

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

  def show
    # before_actionのset_itemによって@itemが定義されているため、中身は空でOK
  end

  def edit
    # 購入機能実装後、以下を生かすことで「売却済み商品の編集」を制限できます
    # if @item.order.present?
    #   redirect_to root_path
    # end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
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

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    return if current_user.id == @item.user_id

    redirect_to root_path
  end
end
