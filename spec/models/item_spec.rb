require 'rails_helper'
# rails_helper：Rails + RSpec を使うための準備ファイル

RSpec.describe Item, type: :model do
  # Itemモデルのテストを書く宣言

  before do
    @item = FactoryBot.build(:item)
    # FactoryBotで「正しいItemのサンプル」を1つ作る
  end

  describe '商品出品機能' do
    # 商品出品に関するテストグループ

    context '出品できるとき' do
      it 'すべての情報が正しく入力されていれば保存できる' do
        expect(@item).to be_valid
        # item が正しければ valid? が true になる
      end
    end

    context '出品できないとき' do
      it '商品名が空だと保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品説明が空だと保存できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end

      it '価格が空だと保存できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が300未満だと保存できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格が9,999,999を超えると保存できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '価格が全角文字だと保存できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '画像が添付されていないと保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'カテゴリーが---だと保存できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が---だと保存できない' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it '配送料の負担が---だと保存できない' do
        @item.delivery_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee can't be blank")
      end

      it '発送元の地域が---だと保存できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数が---だと保存できない' do
        @item.scheduled_delivery_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end
    end
  end
end
