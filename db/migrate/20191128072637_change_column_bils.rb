class ChangeColumnBils < ActiveRecord::Migration[6.0]
  def change
    change_column :bils, :amt, :float
  end
end
