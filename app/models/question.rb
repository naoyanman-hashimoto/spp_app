class Question < ApplicationRecord
# 記述の整理、視認性の確保の為にコメントアウトで情報を記載します
# アソシエーション関係
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre

  belongs_to :user
  has_many :answers
# アソシエーション関係
# バリデーションの設定
  FORBIDDEN_CHARACTERS_REGEX = /[死殺]/

  validates :genre_id, numericality: { other_than: 0, message: "は未選択では保存できません" }

  with_options presence: true do
    validates :user
    validates :question_name,
              format: { without: FORBIDDEN_CHARACTERS_REGEX, message: 'に、使ってはいけない文字が含まれています' }
    validates :question_content, uniqueness: { case_sensitive: true } ,
              format: { without: FORBIDDEN_CHARACTERS_REGEX, message: 'に、使ってはいけない文字が含まれています' }
    validates :model_answer,
              format: { without: FORBIDDEN_CHARACTERS_REGEX, message: 'に、使ってはいけない文字が含まれています' }
    validates :point,
              numericality: { only_integer: true, greater_than_or_equal_to: 10,
                              less_than_or_equal_to: 3000,
                              message: 'が設定できる範囲外です' }
  end
# バリデーションの設定
end
