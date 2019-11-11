class AddColumnDateToBils < ActiveRecord::Migration[6.0]
  def change
    add_column :bils, :date, :date 
  end
end
