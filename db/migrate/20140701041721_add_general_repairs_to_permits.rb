class AddGeneralRepairsToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :repair, :boolean
    add_column :permits, :window, :boolean
    add_column :permits, :door, :boolean
    add_column :permits, :wall, :boolean
    add_column :permits, :siding, :boolean
    add_column :permits, :floor, :boolean
    add_column :permits, :window_count, :integer
    add_column :permits, :door_count, :integer
  end
end
