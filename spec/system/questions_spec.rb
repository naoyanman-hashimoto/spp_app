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
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
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
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email',    with: @user1.email
      fill_in 'user_password', with: @user1.password
      find('input[name="commit"]').click
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
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email',    with: @user1.email
      fill_in 'user_password', with: @user1.password
      find('input[name="commit"]').click
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