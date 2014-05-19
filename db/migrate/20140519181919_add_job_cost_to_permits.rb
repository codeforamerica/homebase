class AddJobCostToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :job_cost, :integer
  end
end
