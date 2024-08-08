class Questionnaire < ApplicationRecord
  has_many :questionnaire_questions, dependent: :destroy
  has_many :questions, through: :questionnaire_questions

  validates :name, presence: true
end
