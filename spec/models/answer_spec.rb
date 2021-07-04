require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe '#create' do
    before do
      user = FactoryBot.create(:user)
      question = FactoryBot.create(:question)
      @answer = FactoryBot.build(:answer, user_id: user.id, question_id: question.id)
      sleep 0.1
    end
    describe '課題回答機能' do
      context '課題回答できる時' do
        it '必要な情報を適切に入力すると、回答した情報がデータベースに保存されること' do
          expect(@answer).to be_valid
        end
      end
      context '課題回答できない時' do
        it '回答内容(answer_content)は空では保存できないこと' do
          @answer.answer_content = ''
          @answer.valid?
          expect(@answer.errors.full_messages).to include("Answer content can't be blank")
        end
        it '回答内容(answer_content)に不適切な言葉(死)が含まれていると保存出来ない' do
          @answer.answer_content = '死ね'
          @answer.valid?
          expect(@answer.errors.full_messages).to include('Answer content is invalid. Contains inappropriate content')
        end
        it '回答内容(answer_content)に不適切な言葉(殺)が含まれていると保存出来ない' do
          @answer.answer_content = '殺す'
          @answer.valid?
          expect(@answer.errors.full_messages).to include('Answer content is invalid. Contains inappropriate content')
        end
        it 'user_idが空では保存できないこと' do
          @answer.user_id = nil
          @answer.valid?
          expect(@answer.errors.full_messages).to include("User can't be blank")
        end
        it 'question_idが空では保存できないこと' do
          @answer.question_id = nil
          @answer.valid?
          expect(@answer.errors.full_messages).to include("Question can't be blank")
        end
      end
    end
  end
end
