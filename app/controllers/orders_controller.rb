# PAY.JP の機能を外部ライブラリとして読み込み
require 'payjp'

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :prevent_invalid_access, only: [:index, :create]

  def index
    # JS側に公開鍵を渡す
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      # バリデーションエラーで戻る際も、JS側で鍵が必要なため再定義
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']

    # 【重要】以前発生した NoMethodError を防ぐためのSSL回避策
    # Ruby自体の証明書チェックを、このメソッドが実行されている間だけ開発環境でオフにします
    # if Rails.env.development?
    #   require 'openssl'
    #   OpenSSL::SSL.const_set(:VERIFY_PEER, OpenSSL::SSL::VERIFY_NONE) unless OpenSSL::SSL.const_defined?(:VERIFY_PEER_ALREADY_SET)
    # end

    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類
    )
  end

  def prevent_invalid_access
    # 出品者本人、または売却済みの場合
    return unless current_user.id == @item.user_id || @item.order.present?

    redirect_to root_path
  end
end
