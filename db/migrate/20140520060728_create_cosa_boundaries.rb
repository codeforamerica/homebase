class CreateCosaBoundaries < ActiveRecord::Migration
  def change
    create_table :cosa_boundaries do |t|
      t.string :name
      t.float :sqmiles
      t.float :shape_area
      t.float :shape_leng
      t.geometry :geom

      t.timestamps
    end
  end
end
