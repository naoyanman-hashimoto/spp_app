FactoryBot.define do
  factory :question do
    genre_id           { 2 }
    question_name      { 'たしざん' }
    question_content   { 1+1 }
    tip                { 'ピース' }
    model_answer       { 2 }
    point             { 100 }
    association :user
  end
end
