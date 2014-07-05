class AddAcsStructToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :acs_struct, :boolean
  end
end
