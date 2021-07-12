class Score < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  with_options presence: true do
    validates :user
    validates :answer
    validates :score,
              numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10,
              message: 'が設定の範囲外です。半角数値の0~10点で入力してください' }
  end
end