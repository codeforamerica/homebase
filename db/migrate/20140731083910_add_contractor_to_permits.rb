class AddContractorToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :contractor, :boolean
  end
end
