class AddCoordToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :lat, :float
    add_column :permits, :lng, :float
  end
end
