require 'rails_helper'

RSpec.describe Question, type: :model do
  describe '#create' do
    before do
      user = FactoryBot.create(:user)
      @question = FactoryBot.build(:question, user_id: user.id)
      sleep 0.1
    end
    describe '課題作成機能' do
      context '課題作成できる時' do
        it '必要な情報を適切に入力すると、課題情報がデータベースに保存されること' do
          expect(@question).to be_valid
        end
        it 'ヒント(tip)は空でもデータベースに保存されること' do
          @question.tip = ''
          expect(@question).to be_valid
        end
      end
      context '課題作成出来ない時' do
        it '課題名(question_name)が空では保存出来ない' do
          @question.question_name = ''
          @question.valid?
          expect(@question.errors.full_messages).to include("Question name can't be blank")
        end
        it '課題名(question_name)に不適切な言葉(死)が含まれていると保存出来ない' do
          @question.question_name = 'この中で誰が死んだでしょう？'
          @question.valid?
          expect(@question.errors.full_messages).to include('Question name is invalid. Contains inappropriate content')
        end
        it '課題名(question_name)に不適切な言葉(殺)が含まれていると保存出来ない' do
          @question.question_name = '私が殺したいのは誰でしょう？'
          @question.valid?
          expect(@question.errors.full_messages).to include('Question name is invalid. Contains inappropriate content')
        end
        it '課題内容(question_content)が空では保存出来ない' do
          @question.question_content = ''
          @question.valid?
          expect(@question.errors.full_messages).to include("Question content can't be blank")
        end
        it '課題内容(question_content)が一意性であること(すでに保存済みの課題内容は、新たに保存できない)' do
          @question.save
          another_question = FactoryBot.build(:question)
          another_question.question_content = @question.question_content
          another_question.valid?
          expect(another_question.errors.full_messages).to include('Question content has already been taken')
        end
        it '課題内容(question_content)に不適切な言葉(死)が含まれていると保存出来ない' do
          @question.question_content = '誰々さんが死んだ'
          @question.valid?
          expect(@question.errors.full_messages).to include('Question content is invalid. Contains inappropriate content')
        end
        it '課題内容(question_content)に不適切な言葉(殺)が含まれていると保存出来ない' do
          @question.question_content = '誰々さんを殺す'
          @question.valid?
          expect(@question.errors.full_messages).to include('Question content is invalid. Contains inappropriate content')
        end
        it '模範解答(model_answer)が空では保存出来ない' do
          @question.model_answer = ''
          @question.valid?
          expect(@question.errors.full_messages).to include("Model answer can't be blank")
        end
        it '模範解答(model_answer)に不適切な言葉(死)が含まれていると保存出来ない' do
          @question.model_answer = '死んだのは誰々さんです'
          @question.valid?
          expect(@question.errors.full_messages).to include('Model answer is invalid. Contains inappropriate content')
        end
        it '模範解答(model_answer)に不適切な言葉(殺)が含まれていると保存出来ない' do
          @question.model_answer = '殺したのは誰々さんです'
          @question.valid?
          expect(@question.errors.full_messages).to include('Model answer is invalid. Contains inappropriate content')
        end
        it '獲得経験値(point)が空では保存出来ない' do
          @question.point = ''
          @question.valid?
          expect(@question.errors.full_messages).to include("Point can't be blank")
        end
        it '獲得経験値(point)が数値以外(漢数字)では保存出来ない' do
          @question.point = '百'
          @question.valid?
          expect(@question.errors.full_messages).to include('Point is out of setting range')
        end
        it '獲得経験値(point)が数値以外(全角かな)では保存出来ない' do
          @question.point = 'ひゃく'
          @question.valid?
          expect(@question.errors.full_messages).to include('Point is out of setting range')
        end
        it '獲得経験値(point)が数値以外(全角カナ)では保存出来ない' do
          @question.point = 'ヒャク'
          @question.valid?
          expect(@question.errors.full_messages).to include('Point is out of setting range')
        end
        it '獲得経験値(point)が数値以外(半角カナ)では保存出来ない' do
          @question.point = 'ﾋｬｸ'
          @question.valid?
          expect(@question.errors.full_messages).to include('Point is out of setting range')
        end
        it '獲得経験値(point)が数値以外(英字)では保存出来ない' do
          @question.point = 'one hundred'
          @question.valid?
          expect(@question.errors.full_messages).to include('Point is out of setting range')
        end
        it '獲得経験値(point)が10以下では保存出来ない' do
          @question.point = 5
          @question.valid?
          expect(@question.errors.full_messages).to include('Point is out of setting range')
        end
        it '獲得経験値(point)が3000以上では保存出来ない' do
          @question.point = 3333
          @question.valid?
          expect(@question.errors.full_messages).to include('Point is out of setting range')
        end
        it 'ジャンル(genre_id)が未選択では保存出来ない' do
          @question.genre_id = 0
          @question.valid?
          expect(@question.errors.full_messages).to include("Genre can't be blank")
        end
        it 'user_idが空では保存できないこと' do
          @question.user_id = nil
          @question.valid?
          expect(@question.errors.full_messages).to include("User can't be blank")
        end
      end
    end
  end
end
