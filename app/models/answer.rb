class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_one    :score

  FORBIDDEN_CHARACTERS_REGEX = /[死殺]/

  with_options presence: true do
  validates :user
  validates :question
  validates :answer_content,
            format: { without: FORBIDDEN_CHARACTERS_REGEX, message: 'is invalid. Contains inappropriate content' }
  end
end
