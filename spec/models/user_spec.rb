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
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'emailが空では登録出来ない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'emailは一意性であること(すでに登録済みのemailでは登録出来ない)' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'passwordが空では登録出来ない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'passwordは6文字以上ないと登録出来ない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordと確認用passwordが一致しないと登録出来ない' do
        @user.password = '123456'
        @user.password_confirmation = '123456789'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'characterが未選択では登録出来ない' do
        @user.character = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('キャラクターをえらんでください')
      end
      it 'character_nameが空では登録出来ない' do
        @user.character_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('キャラクター名を入力してください')
      end
      it 'levelが空では登録出来ない' do
        @user.level = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('レベルを入力してください')
      end
      it 'experience_pointが空では登録出来ない' do
        @user.experience_point = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('経験値を入力してください')
      end
    end
  end
end
