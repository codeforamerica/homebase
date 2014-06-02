class AddAcresToCosaBoundaries < ActiveRecord::Migration
  def change
    add_column :cosa_boundaries, :acres, :float
  end
end
