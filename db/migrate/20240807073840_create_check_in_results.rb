class CreateCheckInResults < ActiveRecord::Migration[6.1]
  def change
    create_table :check_in_results do |t|
      t.references :check_in, index: true, foreign_key: { to_table: :check_ins }
      t.references :questionnaire, index: true, foreign_key: { to_table: :questionnaires }
      t.json :response, null: false, default: {}
      t.integer :count_1, default: 0, null: false
      t.integer :count_2, default: 0, null: false
      t.integer :count_3, default: 0, null: false
      t.integer :total_score, default: 0, null: false

      t.timestamps
    end
  end
end
