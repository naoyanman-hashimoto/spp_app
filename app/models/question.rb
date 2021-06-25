class Question < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre

  belongs_to :user

  with_options presence: true do
    validates :question_name
    validates :question_content
    validates :model_answer
    validates :point,
               numericality: { only_integer: true, greater_than_or_equal_to: 10,
                               less_than_or_equal_to: 3000,
                               message: 'is out of setting range' }
  end
end
