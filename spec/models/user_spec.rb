require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe '新規登録／ユーザー情報' do
    context '新規登録できるとき' do
      it 'パスワードは、半角英数字混合での入力が必須であること（半角英数字が混合されていれば、登録が可能なこと）' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        expect(@user).to be_valid
      end
      it 'パスワードは、確認用を含めて2回入力すること' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        @user.password = @user.password_confirmation
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'sample'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを正しく入力してください')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'パスワードは、6文字以上での入力が必須であること（6文字が入力されていれば、登録が可能なこと）' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
        @user.password = 'a12345'
        @user.password_confirmation = 'b12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'パスワードは英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを正しく入力してください')
      end
      it 'パスワードは数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを正しく入力してください')
      end
      it 'パスワードは全角では登録できない' do
        @user.password = 'ABCDEF'
        @user.password_confirmation = 'ABCDEF'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを正しく入力してください')
      end
    end
  end
  
  describe '新規登録/本人情報確認' do
    it 'ユーザー本名は、名字がそれぞれ必須であること' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前（姓）を入力してください')
    end
    it 'ユーザー本名は、名前がそれぞれ必須であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前（名）を入力してください')
    end
    it 'ユーザー本名は、名字が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.last_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前（姓）を正しく入力してください')
    end
    it 'ユーザー本名は、名前が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前（名）を正しく入力してください')
    end
    it 'ユーザー本名のフリガナは、名字がそれぞれ必須であること' do
      @user.last_name_ruby = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前カナ（姓）を正しく入力してください')
    end
    it 'ユーザー本名のフリガナは、名前がそれぞれ必須であること' do
      @user.first_name_ruby = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前カナ（名）を入力してください')
    end
    it 'ユーザー本名のフリガナは、名字が全角（カタカナ）での入力が必須であること' do
      @user.last_name_ruby = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前カナ（姓）を正しく入力してください')
    end
    it 'ユーザー本名のフリガナは、名前が全角（カタカナ）での入力が必須であること' do
      @user.first_name_ruby = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前カナ（名）を正しく入力してください')
    end
    it '生年月日が必須であること' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('生年月日を入力してください')
    end
  end
end
