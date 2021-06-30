FactoryBot.define do
  factory :answer do
    association :user
    association :question
    answer_content   { 10 }
  end
end
