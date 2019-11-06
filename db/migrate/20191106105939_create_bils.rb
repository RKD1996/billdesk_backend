class CreateBils < ActiveRecord::Migration[6.0]
  def change
    create_table :bils do |t|
      t.string :name
      t.integer :amt


      t.timestamps
    end
  end
end
