class QuestionnaireQuestion < ApplicationRecord
  belongs_to :questionnaire
  belongs_to :question


  private

  def assign_order
    if order.present?
      if self.class.exists?(questionnaire_id:, order:)
        errors.add(:order, 'is already taken for this questionnaire')
        throw(:abort)
      end
    else
      self.order = next_available_order
    end
  end

  def next_available_order
    max_order = self.class.where(questionnaire_id:).maximum(:order)
    max_order ? max_order + 1 : 1
  end
end
