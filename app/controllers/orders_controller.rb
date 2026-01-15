class OrdersController < ApplicationController
  before_action :authenticate_user! # ログインしていない人はログイン画面へ
  before_action :set_item, only: [:index, :create]
  # 出品者や売却済み商品の購入を防ぐ制限を追加
  before_action :prevent_invalid_access, only: [:index, :create]

  def index
    # JS側に環境変数を渡す
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      # 保存の前に決済処理を実行する
      pay_item
      @order_address.save
      redirect_to root_path
    else
      # バリデーションエラーで購入ページに戻る際も、JS側で鍵が必要になるため再定義
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    # フォームで入力された情報 + 商品ID + ユーザーID をまとめる
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  # PAY.JPに決済を依頼するメソッド
  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  # 不正なアクセス（自分が出品した商品の購入など）をトップページへ戻す
  def prevent_invalid_access
    return unless current_user.id == @item.user_id || @item.order.present?

    redirect_to root_path
  end
end
