class RemoveContractorFromPermits < ActiveRecord::Migration
  def change
    remove_column :permits, :contractor, :boolean
    remove_column :permits, :contractor_name, :string
    remove_column :permits, :contractor_id, :string
    remove_column :permits, :escrow, :boolean
    remove_column :permits, :license_holder, :string
    remove_column :permits, :license_num, :string
    remove_column :permits, :agent_name, :string
    remove_column :permits, :contact_id, :string
    remove_column :permits, :other_contact_id, :string
    remove_column :permits, :fax, :string
  end
end
