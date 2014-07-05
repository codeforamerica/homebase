class AddDeckToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :deck, :boolean
  end
end
