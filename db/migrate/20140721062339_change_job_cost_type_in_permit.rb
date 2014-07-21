class ChangeJobCostTypeInPermit < ActiveRecord::Migration
  def up
    change_column :permits, :job_cost, :decimal, :precision => 15, :scale => 2
  end
 
  def down
    change_column :permits, :job_cost, :integer
  end

end
