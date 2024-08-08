class CheckIn < ApplicationRecord
  has_many :check_in_results, dependent: :destroy

  validates :patient_id, presence: true
  validates :date, presence: true
end
