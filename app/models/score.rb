class Score < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  validates :score, presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10,
            message: 'is out of setting range' }
end