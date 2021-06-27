require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
    sleep 0.1
  end
  describe 'ユーザー新規登録' do

    context 'ユーザー新規登録できる時' do
      it '必要な情報を正しく入力すると新規登録できる' do
        expect(@user).to be_valid
      end
    end
    context 'ユーザー新規登録出来ない時' do
      it 'nicknameが空では登録出来ない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録出来ない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailは一意性であること(すでに登録済みのemailでは登録出来ない)' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空では登録出来ない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordは6文字以上ないと登録出来ない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordと確認用passwordが一致しないと登録出来ない' do
        @user.password = '123456'
        @user.password_confirmation = '123456789'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'character_nameが空では登録出来ない' do
        @user.character_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Character name can't be blank")
      end
      it 'levelが空では登録出来ない' do
        @user.level = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Level can't be blank")
      end
      it 'experience_pointが空では登録出来ない' do
        @user.experience_point = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Experience point can't be blank")
      end
    end

  end
end
