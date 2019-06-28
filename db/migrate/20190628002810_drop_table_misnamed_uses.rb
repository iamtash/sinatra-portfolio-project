class DropTableMisnamedUses < ActiveRecord::Migration
  def change
    drop_table :uses
  end
end
