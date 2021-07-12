require 'rails_helper'

RSpec.describe Score, type: :model do
  describe '#create' do
    before do
      user = FactoryBot.create(:user)
      answer = FactoryBot.create(:answer)
      @score = FactoryBot.build(:score, user_id: user.id, answer_id: answer.id)
      sleep 0.1
    end
    describe '回答採点機能' do
      context '回答採点できる時' do
        it '必要な情報を適切に入力すると、採点した情報がデータベースに保存されること' do
          expect(@score).to be_valid
        end
      end
      context '回答採点できない時' do
        it '点数が空では保存されないこと' do
          @score.score = ''
          @score.valid?
          expect(@score.errors.full_messages).to include('点数を入力してください')
        end
        it '点数が10点以上では保存されないこと' do
          @score.score = '11'
          @score.valid?
          expect(@score.errors.full_messages).to include('点数が設定の範囲外です。半角数値の0~10点で入力してください')
        end
        it '点数が0点以下では保存されないこと' do
          @score.score = '-1'
          @score.valid?
          expect(@score.errors.full_messages).to include('点数が設定の範囲外です。半角数値の0~10点で入力してください')
        end
        it '点数は全角数値では保存されないこと' do
          @score.score = '１０'
          @score.valid?
          expect(@score.errors.full_messages).to include('点数が設定の範囲外です。半角数値の0~10点で入力してください')
        end
        it '点数は漢数字では保存されないこと' do
          @score.score = '十'
          @score.valid?
          expect(@score.errors.full_messages).to include('点数が設定の範囲外です。半角数値の0~10点で入力してください')
        end
        it '点数は英字では保存されないこと' do
          @score.score = 'ten'
          @score.valid?
          expect(@score.errors.full_messages).to include('点数が設定の範囲外です。半角数値の0~10点で入力してください')
        end
        it '点数は半英数字混同では保存できないこと' do
          @score.score = '1o'
          @score.valid?
          expect(@score.errors.full_messages).to include('点数が設定の範囲外です。半角数値の0~10点で入力してください')
        end
        it 'user_idが空では保存できないこと' do
          @score.user_id = nil
          @score.valid?
          expect(@score.errors.full_messages).to include("Userを入力してください")
        end
        it 'answer_idが空では保存できないこと' do
          @score.answer_id = nil
          @score.valid?
          expect(@score.errors.full_messages).to include("Answerを入力してください")
        end
      end
    end
  end
end
