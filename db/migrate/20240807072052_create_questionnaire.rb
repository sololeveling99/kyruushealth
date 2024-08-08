class CreateQuestionnaire < ActiveRecord::Migration[6.1]
  def change
    create_table :questionnaires do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
