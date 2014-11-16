class RenamePermitsToProjects < ActiveRecord::Migration
  def change
    rename_table :permits, :projects
  end
end
