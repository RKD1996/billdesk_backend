class AddUsernameToBils < ActiveRecord::Migration[6.0]
  def change
    add_column :bils, :username, :string
  end
end
