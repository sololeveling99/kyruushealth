FactoryBot.define do
  factory :questionnaire_question do
    association :questionnaire
    association :question
    order { 1 }
  end
end
