require 'rails_helper'

def basic_pass
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
end

RSpec.describe "解答採点", type: :system do
  before do
    # 出題者ユーザー
    @user1 = FactoryBot.create(:user)
    # 解答者ユーザー
    @user2 = FactoryBot.create(:user)
    # 課題1
    @question1 = FactoryBot.create(:question, user_id: @user1.id)
    # ユーザー2による解答
    @answer = FactoryBot.create(:answer, user_id: @user2.id, question_id: @question1.id)
    sleep 0.1
  end
  context '解答採点できるとき' do
    it 'ログインしたユーザーは課題回答後、採点する事ができる' do
      # ユーザー2でログインする
      basic_pass
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email',    with: @user2.email
      fill_in 'user_password', with: @user2.password
      find('input[name="commit"]').click
      # トップページに遷移する事を確認する
      expect(current_path).to eq(root_path)
      # トップページ下部に課題1へのリンクがある事を確認する
      expect(page).to have_link(@question1.question_name, href: new_question_answer_path(@question1))
      # トップページ下部の課題1を選択する
      find_link(@question1.question_name, href: new_question_answer_path(@question1)).click
      # 課題解答ページに遷移した事を確認する
      expect(current_path).to eq(new_question_answer_path(@question1))
      # 解答を入力する
      fill_in 'answer_answer_content', with: @answer.answer_content
      # 解答する
      find('input[name="commit"]').click
      # 回答完了ページに遷移した事を確認する
      expect(current_path).to eq(question_answer_scores_path(@question1, @answer.id+1))
      # 採点ページへのリンクである「こたえあわせをする」ボタンがある事を確認する
      expect(page).to have_link('こたえあわせをする', href: new_question_answer_score_path(@question1, @answer.id+1))
      # 採点ページへ移動する
      find_link('こたえあわせをする', href: new_question_answer_score_path(@question1, @answer.id+1)).click
      # 採点ページへ遷移した事を確認する
      expect(current_path).to eq(new_question_answer_score_path(@question1, @answer.id+1))
      # 採点結果を入力する
      fill_in 'score_score', with: 10
      binding.pry
      # 採点完了するとScoreモデルのカウントが1上がる事を確認する
      expect{
        find('input[name="commit"]').click
      }.to change{Score.count}.by(1)
      # トップページに遷移した事を確認する
      expect(current_path).to eq(root_path)
    end
  end
  context '解答採点できないとき' do
    it 'ログインしていないユーザーは課題選択ページから課題解答できずにログインページに遷移する(即ち、採点できない)' do
      # トップページにいる
      visit root_path
      # 課題選択ページに移動する
      select 'さんすう', from: 'q_genre_id_eq'
      find('input[value="もんだいをえらぶ"]').click
      # 課題選択ページに遷移した事を確認する
      expect(page).to have_content('さんすうのもんだいページです')
      # 課題1を選択する
      find_link(@question1.question_name, href: new_question_answer_path(@question1)).click
      # 課題解答ページに遷移せずにログインページへ遷移した事を確認する
      expect(current_path).to eq(user_session_path)
    end
    it 'ログインしていないユーザーはトップページから課題解答できずにログインページに遷移する(即ち、採点できない)' do
      # トップページにいる
      visit root_path
      # トップページ下部に課題1へのリンクがある事を確認する
      expect(page).to have_link(@question1.question_name, href: new_question_answer_path(@question1))
      # トップページ下部の課題1を選択する
      find_link(@question1.question_name, href: new_question_answer_path(@question1)).click
      # 課題解答ページに遷移せずにログインページへ遷移した事を確認する
      expect(current_path).to eq(user_session_path)
    end
  end
end
