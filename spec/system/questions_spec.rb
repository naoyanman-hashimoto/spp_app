require 'rails_helper'

def basic_pass
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
end

RSpec.describe '課題作成', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @question = FactoryBot.build(:question, user_id: @user.id)
    sleep 0.1
  end
  context '課題作成ができるとき'do
    it 'ログインしたユーザーは課題作成できる' do
      # ログインする
      basic_pass
      sign_in(@user)
      # トップページへ遷移する事を確認する
      expect(current_path).to eq(root_path)
      # 課題作成ページへのボタンがあることを確認する
      expect(page).to have_content('課題を作成する')
      # 課題作成ページに移動する
      find('a[class="new-question-btn"]').click
      # フォームに情報を入力する
      select 'さんすう', from: 'question_genre_id'
      fill_in 'question[question_name]', with: @question.question_name
      fill_in 'question[question_content]', with: @question.question_content
      fill_in 'question[tip]', with: @question.tip
      fill_in 'question[model_answer]', with: @question.model_answer
      fill_in 'question[point]', with: @question.point
      # 出題するとQuestionモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {Question.count}.by(1)
      # トップページに遷移した事を確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど作成した内容の課題が存在することを確認する(課題名)
      expect(page).to have_content(@question.question_name)
      # 課題選択ページに移動する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      # 課題選択ページにも先ほど作成した内容の課題が存在する事を確認する(課題名)
      expect(page).to have_content(@question.question_name)
    end
  end
  context '課題作成ができないとき'do
    it 'ログインしていないと課題作成ページに遷移できない' do
      # トップページに移動する
      visit root_path
      # 課題作成ページへのボタンがあることを確認する
      expect(page).to have_content('課題を作成する')
      # 課題作成ページに移動しようとする
      find('a[class="new-question-btn"]').click
      # ログインページに遷移する事を確認する
      expect(current_path).to eq(user_session_path)
    end
  end
end

RSpec.describe '課題編集', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @question1 = FactoryBot.create(:question, user_id: @user1.id)
    @question2 = FactoryBot.create(:question, user_id: @user2.id)
    sleep 0.1
  end
  context '課題編集ができるとき' do
    it 'ログインしたユーザーは自分が作成した課題の編集ができる' do
      # 課題1を作成したユーザーでログインする
      sign_in(@user1)
      # トップページへ遷移する事を確認する
      expect(current_path).to eq(root_path)
      # 課題選択ページに移動する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      # 課題選択ページに遷移した事を確認する
      expect(page).to have_content('のもんだいページです')
      # 作成した課題1には「編集」へのリンクはある事を確認する
      expect(page).to have_content(@question1.question_name)
      expect(page).to have_link'編集', href: edit_question_path(@question1)
      # 編集ページへ遷移する
      visit edit_question_path(@question1)
      # 既に投稿済の課題内容がフォームに入力されている事を確認する
      # genre_idの確認
      expect(
        find('#question_genre_id').value.to_i
      ).to eq(@question1.genre_id)
      # 課題名の確認
      expect(
        find('#question_question_name').value
      ).to eq(@question1.question_name)
      # 課題内容の確認
      expect(
        find('#question_question_content').value
      ).to eq(@question1.question_content)
      # ヒントの確認
      expect(
        find('#question_tip').value
      ).to eq(@question1.tip)
      # 模範解答の確認
      expect(
        find('#question_model_answer').value
      ).to eq(@question1.model_answer)
      # 獲得できる経験値の確認
      expect(
        find('#question_point').value.to_i
      ).to eq(@question1.point)
      # 課題内容を編集する
      fill_in 'question[question_name]', with: "#{@question1.question_name}+編集した課題名"
      fill_in 'question[question_content]', with: "#{@question1.question_content}+編集した課題内容"
      fill_in 'question[tip]', with: "#{@question1.tip}+編集したヒント"
      fill_in 'question[model_answer]', with: "#{@question1.model_answer}+編集した模範解答"
      fill_in 'question[point]', with: "#{@question1.point+100}"
      # 編集してもQuestionモデルのカウントは変わらない事を確認する
      expect{
        find('input[name="commit"]').click
      }.to change{Question.count}.by(0)
      # トップページに遷移した事を確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど編集した内容の課題が存在する事を確認する
      expect(page).to have_content("#{@question1.question_name}+編集した課題名")
      # 課題選択ページにも先ほど編集した内容の課題が存在する事を確認する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      expect(page).to have_content("#{@question1.question_name}+編集した課題名")
    end
  end
  context '課題編集ができないとき' do
    it 'ログインしたユーザーは自分以外が作成した課題の編集画面には遷移できない' do
      # 課題1を作成したユーザーでログインする
      sign_in(@user1)
      # トップページへ遷移する事を確認する
      expect(current_path).to eq(root_path)
      # 課題選択ページへ移動する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      # 課題2に「編集」へのリンクがない事を確認する
      expect(page).to have_content(@question2.question_name)
      expect(page).to have_no_link'編集', href: edit_question_path(@question2)
    end
    it 'ログインしていないと編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      expect(current_path).to eq(root_path)
      # 課題選択ページに移動する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      # 課題1に「編集」へのリンクがない事を確認する
      expect(page).to have_content(@question1.question_name)
      expect(page).to have_no_link'編集', href: edit_question_path(@question1)
      # 課題2に「編集」へのリンクがない事を確認する
      expect(page).to have_content(@question2.question_name)
      expect(page).to have_no_link'編集', href: edit_question_path(@question2)
    end
  end
end

RSpec.describe '課題削除', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @question1 = FactoryBot.create(:question, user_id: @user1.id)
    @question2 = FactoryBot.create(:question, user_id: @user2.id)
    sleep 0.1
  end
  context '課題削除ができるとき' do
    it 'ログインしたユーザーは自分が作成した課題の編集ができる' do
      # 課題1を作成したユーザーでログインする
      sign_in(@user1)
      # トップページへ遷移する事を確認する
      expect(current_path).to eq(root_path)
      # 課題選択ページに移動する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      # 課題選択ページに遷移した事を確認する
      expect(page).to have_content('のもんだいページです')
      # 作成した課題1には「削除」へのリンクはある事を確認する
      expect(page).to have_content(@question1.question_name)
      expect(page).to have_link'削除', href: question_path(@question1)
      # 課題を削除するとQuestionモデルのカウントが1減ることを確認する
      expect{
      find_link('削除',href: question_path(@question1)).click
      }.to change{Question.count}.by(-1)
      # トップページへ遷移する事を確認する
      expect(current_path).to eq(root_path)
      # トップページには課題1の課題が存在しない事を確認する
      expect(page).to have_no_content(@question1.id)
      # 課題選択ページにも先ほど編集した内容の課題が存在しない事を確認する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      expect(page).to have_no_content(@question1.id)
    end
  end
  context '課題削除できないとき' do
    it 'ログインしたユーザーは自分以外が作成した課題の削除ができない' do
      # 課題1を作成したユーザーでログインする
      sign_in(@user1)
      # トップページへ遷移する事を確認する
      expect(current_path).to eq(root_path)
      # 課題選択ページに移動する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      # 課題選択ページへ遷移した事を確認する
      expect(page).to have_content('のもんだいページです')
      # 課題2には「削除」へのリンクがない事を確認する
      expect(page).to have_no_link('削除', href: question_path(@question2))
    end
    it 'ログインしていないと削除ボタンが表示されない' do
      # トップページにいる
      visit root_path
      expect(current_path).to eq(root_path)
      # 課題選択ページに移動する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      # 課題選択ページに遷移した事を確認する
      expect(page).to have_content('のもんだいページです')
      # 課題1に「削除」へのリンクがない事を確認する
      expect(page).to have_no_link('削除', href: question_path(@question1))
      # 課題2に「削除」へのリンクがない事を確認する
      expect(page).to have_no_link('削除', href: question_path(@question2))
    end
    it '既に回答者のいる問題は削除できない' do
      # 課題1を作成したユーザーでログインする
      sign_in(@user1)
      # トップページへ遷移する事を確認する
      expect(current_path).to eq(root_path)
      # 課題選択ページに移動する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      # 課題選択ページへ遷移した事を確認する
      expect(page).to have_content('のもんだいページです')
      # この時点で課題1には「削除」へのリンクがある事を確認する
      expect(page).to have_link('削除', href: question_path(@question1))
      # ログアウトする
      find_link('ログアウト',href: destroy_user_session_path).click
      # トップページへ遷移した事を確認する
      expect(current_path).to eq(root_path)
      # 課題1を作成していないユーザーでログインする
      sign_in(@user2)
      # トップページへ遷移する事を確認する
      expect(current_path).to eq(root_path)
      # 課題選択ページに移動する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      # 課題選択ページへ遷移した事を確認する
      expect(page).to have_content('のもんだいページです')
      # 課題1を選択する
      find_link(@question1.question_name, href: new_question_answer_path(@question1)).click
      # 課題回答ページに遷移した事を確認する
      expect(current_path).to eq(new_question_answer_path(@question1))
      # 回答を入力する
      @answer = FactoryBot.create(:answer, user_id: @user2.id, question_id: @question1.id)
      fill_in 'answer_answer_content', with: @answer.answer_content
      # 回答する
      find('input[name="commit"]').click
      # 回答完了ページに遷移した事を確認する
      expect(current_path).to eq(question_answer_scores_path(@question1, @answer.id+1))
      # 「こたえあわせをする」のリンクがある事を確認する
      expect(page).to have_link('こたえあわせをする', href: new_question_answer_score_path(@question1, @answer.id+1))
      # トップページに遷移する
      visit root_path
      # ログアウトする
      find_link('ログアウト',href: destroy_user_session_path).click
      # 課題1を作成したユーザーでログインする
      sign_in(@user1)
      # トップページへ遷移する事を確認する
      expect(current_path).to eq(root_path)
      # 課題選択ページに移動する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      # 課題選択ページへ遷移した事を確認する
      expect(page).to have_content('のもんだいページです')
      # 課題1に「削除」へのリンクが無くなっている事を確認する
      expect(page).to have_no_link('削除', href: question_path(@question1))
      # 「すでに解答者がいる為、削除はできません」の文字が表示されている事を確認する
      expect(page).to have_content('すでに解答者がいる為、削除はできません')
    end
  end
end