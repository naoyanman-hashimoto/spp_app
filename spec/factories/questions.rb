FactoryBot.define do
  factory :question do
    genre_id           { 2 }
    question_name      { 'たしざんテスト' }
    question_content   { Faker::JapaneseMedia::Naruto.character }
    tip                { 'ピース' }
    model_answer       { 2 }
    point             { 100 }
    association :user
  end
end
