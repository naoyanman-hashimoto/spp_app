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