FactoryBot.define do
  factory :score do
    association :user
    association :answer
    score       { 10 }
  end
end
