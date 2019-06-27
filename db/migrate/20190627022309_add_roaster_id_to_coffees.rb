class AddRoasterIdToCoffees < ActiveRecord::Migration
  def change
    add_column :coffees, :roaster_id, :integer
  end
end
