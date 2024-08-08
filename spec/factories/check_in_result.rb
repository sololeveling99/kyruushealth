FactoryBot.define do
  factory :check_in_result do
    association :check_in
    association :questionnaire
    response { {} }
    count_1 { 0 }
    count_2 { 0 }
    count_3 { 0 }
    total_score { 0 }
  end
end
