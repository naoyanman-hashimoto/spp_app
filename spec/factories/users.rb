FactoryBot.define do
  factory :user do
    nickname              {Faker::Games::Pokemon.name}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password}
    password_confirmation {password}
    character_name        {Faker::JapaneseMedia::DragonBall.character}
    level                 { 1 }
    experience_point      { 0 }
  end
end
