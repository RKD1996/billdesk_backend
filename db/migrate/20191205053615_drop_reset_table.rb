class DropResetTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :resets
  end
end
