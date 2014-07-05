class AddPoolToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :pool, :boolean
  end
end
