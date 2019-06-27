class CreateUsers < ActiveRecord::Migration
  def change
    create_table :uses do |t| 
      t.string :first_name
      t.string :last_name 
      t.string :email 
      t.string :password_digest
    end
  end
end
