class AddStatusToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :status, :string
  end
end
