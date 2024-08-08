class CreateQuestionnaireQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questionnaire_questions do |t|
      t.references :questionnaire, index: true, foreign_key: { to_table: :questionnaires }
      t.references :question, index: true, foreign_key: { to_table: :questions }
      t.integer :order

      t.timestamps
    end

    add_index :questionnaire_questions, %i[questionnaire_id order], unique: true
  end
end