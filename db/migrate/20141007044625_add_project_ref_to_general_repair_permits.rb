class AddProjectRefToGeneralRepairPermits < ActiveRecord::Migration
  def change
    add_reference :general_repair_permits, :project, index: true
  end
end
