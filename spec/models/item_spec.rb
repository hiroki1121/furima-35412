require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    context '商品を出品できる' do
      it '情報を全て入力すると出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品を出品できない' do
      it '商品画像を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が必須であること' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end
      it '商品の説明が必須であること' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーの情報が必須であること' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態についての情報が必須であること' do
        @item.product_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product status can't be blank")
      end
      it '配送料の負担についての情報が必須であること' do
        @item.shipping_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping can't be blank")
      end
      it '発送元の地域についての情報が必須であること' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数についての情報が必須であること' do
        @item.delivery_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      end
      it '販売価格についての情報が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", 'Price is not a number')
      end
      it '販売価格は、¥300~¥9,999,999の間のみ保存可能であること(300未満で実施)' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '販売価格は、¥300~¥9,999,999の間のみ保存可能であること(10000000以上で実施)' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '販売価格は半角数字のみ保存可能であること(ひらがなの場合でテスト)' do
        @item.price = 'テスト'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '販売価格は半角数字のみ保存可能であること(カタカナの場合でテスト)' do
        @item.price = 'テスト'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '販売価格は半角数字のみ保存可能であること(英字の場合でテスト)' do
        @item.price = 'test'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '販売価格は半角数字のみ保存可能であること(全角数字の場合でテスト)' do
        @item.price = '１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
