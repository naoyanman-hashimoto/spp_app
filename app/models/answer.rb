class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_one    :score

  FORBIDDEN_CHARACTERS_REGEX = /[死殺]/

  validates :answer_content, presence: true, 
            format: { without: FORBIDDEN_CHARACTERS_REGEX, message: 'is invalid. Contains inappropriate content' }
end
