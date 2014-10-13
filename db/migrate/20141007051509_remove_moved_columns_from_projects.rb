class RemoveMovedColumnsFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :addition, :boolean
    remove_column :projects, :house_area, :integer
    remove_column :projects, :addition_area, :integer
    remove_column :projects, :ac, :string
    remove_column :projects, :window, :boolean
    remove_column :projects, :window_count, :integer
    remove_column :projects, :door, :boolean
    remove_column :projects, :door_count, :integer
    remove_column :projects, :wall, :boolean
    remove_column :projects, :siding, :boolean
    remove_column :projects, :floor, :boolean
    remove_column :projects, :cover, :boolean
    remove_column :projects, :pool, :boolean
    remove_column :projects, :deck, :boolean
    remove_column :projects, :acs_struct, :boolean
    remove_column :projects, :accepted_terms, :boolean
    remove_column :projects, :work_summary, :text
    remove_column :projects, :job_cost, :decimal
  end
end
