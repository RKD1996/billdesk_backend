class CreateResets < ActiveRecord::Migration[6.0]
  def change
    create_table :resets do |t|
      t.string :username
      t.string :reset_token
      
      t.timestamps
    end
  end
end
