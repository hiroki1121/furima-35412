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
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Password is invalid')
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'sample'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、6文字以上での入力が必須であること（6文字が入力されていれば、登録が可能なこと）' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
        @user.password = 'a12345'
        @user.password_confirmation = 'b12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードは英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードは数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードは全角では登録できない' do
        @user.password = 'ABCDEF'
        @user.password_confirmation = 'ABCDEF'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
    end
  end

  describe '新規登録/本人情報確認' do
    it 'ユーザー本名は、名字がそれぞれ必須であること' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'ユーザー本名は、名前がそれぞれ必須であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'ユーザー本名は、名字が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.last_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid')
    end
    it 'ユーザー本名は、名前が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end
    it 'ユーザー本名のフリガナは、名字がそれぞれ必須であること' do
      @user.last_name_ruby = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name ruby can't be blank")
    end
    it 'ユーザー本名のフリガナは、名前がそれぞれ必須であること' do
      @user.first_name_ruby = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name ruby can't be blank")
    end
    it 'ユーザー本名のフリガナは、名字が全角（カタカナ）での入力が必須であること' do
      @user.last_name_ruby = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name ruby is invalid')
    end
    it 'ユーザー本名のフリガナは、名前が全角（カタカナ）での入力が必須であること' do
      @user.first_name_ruby = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name ruby is invalid')
    end
    it '生年月日が必須であること' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
