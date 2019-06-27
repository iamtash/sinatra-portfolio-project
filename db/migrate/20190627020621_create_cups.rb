class CreateCups < ActiveRecord::Migration
  def change
    create_table :cups do |t| 
      t.string :brew
      t.integer :user_id 
      t.integer :coffee_id
      t.timestamps null: false
    end
  end
end
