class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :question_statement, null: false
      t.boolean :severe, default: false, null: false

      t.timestamps
    end
  end
end
