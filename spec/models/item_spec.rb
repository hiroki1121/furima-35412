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
        expect(@item.errors.full_messages).to include('出品画像を入力してください')
      end
      it '商品名が必須であること' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end
      it '商品の説明が必須であること' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end
      it 'カテゴリーの情報が必須であること' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを入力してください')
      end
      it 'カテゴリーのidが1では出品できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーは---以外を選択してください')
      end
      it '商品の状態についての情報が必須であること' do
        @item.product_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を入力してください')
      end
      it '商品の状態のidが1では出品できないこと' do
        @item.product_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態は---以外を選択してください')
      end
      it '配送料の負担についての情報が必須であること' do
        @item.shipping_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を入力してください')
      end
      it '配送料の負担のidが1では出品できないこと' do
        @item.shipping_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担は---以外を選択してください')
      end
      it '発送元の地域についての情報が必須であること' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を入力してください')
      end
      it '発送元の地域のidが1では出品できないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域は---以外を選択してください')
      end
      it '発送までの日数についての情報が必須であること' do
        @item.delivery_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を入力してください')
      end
      it '発送までの日数のidが1では出品できないこと' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数は---以外を選択してください')
      end
      it '販売価格についての情報が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格を入力してください', '販売価格は数値で入力してください')
      end
      it '販売価格は、¥300~¥9,999,999の間のみ保存可能であること(300未満で実施)' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300以上の値にしてください')
      end
      it '販売価格は、¥300~¥9,999,999の間のみ保存可能であること(10000000以上で実施)' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は9999999以下の値にしてください')
      end
      it '販売価格は半角数字のみ保存可能であること(ひらがなの場合でテスト)' do
        @item.price = 'てすと'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '販売価格は半角数字のみ保存可能であること(カタカナの場合でテスト)' do
        @item.price = 'テスト'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '販売価格は半角数字のみ保存可能であること(英字の場合でテスト)' do
        @item.price = 'test'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '販売価格は半角数字のみ保存可能であること(全角数字の場合でテスト)' do
        @item.price = '１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '販売価格は半角数字のみ保存可能であること(半角英数字混合の場合でテスト)' do
        @item.price = 'ab12'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
    end
  end
end
