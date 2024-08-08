class CheckInResult < ApplicationRecord
  belongs_to :check_in
  belongs_to :questionnaire

  validates :response, presence: true

  before_save :calculate_scores

  private

  def response_format
    return if response.is_a?(Array) && response.none? { |r| !r.is_a?(Hash) }

    errors.add(:response, 'must be an array of hashes')
  end

  def calculate_scores
    self.count_1 = response.count { |r| r['response_option_num'] == '1' }
    self.count_2 = response.count { |r| r['response_option_num'] == '2' }
    self.count_3 = response.count { |r| r['response_option_num'] == '3' }
    self.total_score = (count_1 * 1) + (count_2 * 2) + (count_3 * 3)
  end

  def self.determine_severity(score)
    SEVERITY_LEVELS.each do |range, severity|
      return severity if range.include?(score)
    end
    'Unknown severity'
  end

end
