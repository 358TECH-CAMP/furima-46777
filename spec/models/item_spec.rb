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
      # 正常系（うまくいくケース）

      it 'すべての情報が正しく入力されていれば保存できる' do
        expect(@item).to be_valid
        # item が正しければ valid? が true になる
      end
    end

    context '出品できないとき' do
      # 異常系（失敗するケース）

      it '商品名が空だと保存できない' do
        @item.name = ''
        # 商品名を空にする

        @item.valid?
        # バリデーションを実行

        expect(@item.errors.full_messages).to include("Name can't be blank")
        # エラーメッセージが含まれているか確認
      end
    end
  end
end
