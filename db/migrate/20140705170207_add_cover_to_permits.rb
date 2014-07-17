class AddCoverToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :cover, :boolean
  end
end
