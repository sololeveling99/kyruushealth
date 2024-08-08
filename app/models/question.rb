class Question < ApplicationRecord
  has_many :questionnaire_questions, dependent: :destroy
  has_many :questionnaires, through: :questionnaire_questions

  validates :question_statement, presence: true
end
