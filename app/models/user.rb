class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions

  with_options presence: true do
    validates :nickname
    validates :character_name
    validates :level
    validates :experience_point
  end
end
