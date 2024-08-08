class AddDateColumnToCheckIns < ActiveRecord::Migration[6.1]
  def change
    add_column :check_ins, :date, :date
  end
end
