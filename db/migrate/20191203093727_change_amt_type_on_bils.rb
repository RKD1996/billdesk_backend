class ChangeAmtTypeOnBils < ActiveRecord::Migration[6.0]
  def change
    change_column :bils, :amt, :bigint
  end
end
