require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    sleep 0.1
    @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id, item_id: item.id)
  end
  describe '商品購入機能' do
    context '商品を購入でききる' do
      it '必要な情報を適切に入力すると、商品の購入ができる' do
        expect(@order_delivery).to be_valid
      end
      it '建物名が未入力でも購入可能' do
        @order_delivery.building_name = ''
        expect(@order_delivery).to be_valid
      end
    end
    context '商品を購入できない' do
      it 'クレジットカード情報は必須であること（tokenが空では登録できないこと）' do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('クレジットカード情報を入力してください')
      end
      it '配送先の情報として、郵便番号が必須であること' do
        @order_delivery.post_code = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('郵便番号を入力してください')
      end
      it '配送先の情報として、郵便番号が正しい記述になっていること' do
        @order_delivery.post_code = '8100000'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('郵便番号を正しく入力してください')
      end
      it '配送先の情報として、都道府県が1では出品できないこと（初期値が1）' do
        @order_delivery.prefecture_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('都道府県は---以外を選択してください')
      end
      it '配送先の情報として、市区町村が必須であること' do
        @order_delivery.municipality = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('市区町村を入力してください')
      end
      it '配送先の情報として、番地が必須であること' do
        @order_delivery.address = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('番地を入力してください')
      end
      it '配送先の情報として、電話番号が必須であること' do
        @order_delivery.phone_num = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号を入力してください')
      end
      it '電話番号は11桁以内の数値のみ保存可能なこと（12桁）' do
        @order_delivery.phone_num = '123456789123'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号を正しく入力してください')
      end
      it '電話番号は11桁以内の数値のみ保存可能なこと（ひらがな）' do
        @order_delivery.phone_num = 'あいうえおかきくけこさ'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号を正しく入力してください')
      end
      it '電話番号は11桁以内の数値のみ保存可能なこと（カタカナ）' do
        @order_delivery.phone_num = 'アイウエオカキクケコサ'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号を正しく入力してください')
      end
      it '電話番号は11桁以内の数値のみ保存可能なこと（全角数字）' do
        @order_delivery.phone_num = '１２３４５６７８９１２３'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号を正しく入力してください')
      end
      it 'user_idが存在していることが必須' do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Userを入力してください')
      end
      it 'item_idが存在していることが必須' do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
