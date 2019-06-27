class CreateCoffees < ActiveRecord::Migration
  def change
    create_table :coffees do |t| 
      t.string :name 
      t.string :roast 
    end
  end
end
