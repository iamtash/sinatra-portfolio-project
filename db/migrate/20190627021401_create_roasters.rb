class CreateRoasters < ActiveRecord::Migration
  def change
    create_table :roasters do |t|
      t.string :name
    end
  end
end
