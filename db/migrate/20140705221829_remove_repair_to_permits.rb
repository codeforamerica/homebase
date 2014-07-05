class RemoveRepairToPermits < ActiveRecord::Migration
  def change
    remove_column :permits, :repair, :boolean
  end
end
