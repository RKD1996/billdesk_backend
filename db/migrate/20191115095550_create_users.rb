class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.index :username
      t.string :password_digest
      t.string :password_salt
      t.string :name
      t.string :mobile
      t.string :email

      t.timestamps
    end
  end
end
