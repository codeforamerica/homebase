class CreateGeneralRepairPermits < ActiveRecord::Migration
  def change
    create_table :general_repair_permits do |t|
      t.boolean :addition
      t.integer :house_area
      t.integer :addition_area
      t.string :ac
      t.boolean :window
      t.integer :window_count
      t.boolean :door
      t.integer :door_count
      t.boolean :wall
      t.boolean :siding
      t.boolean :floor
      t.boolean :cover
      t.boolean :pool
      t.boolean :deck
      t.boolean :acs_struct
      t.boolean :accepted_terms
      t.text :work_summary

      t.decimal :job_cost, :precision => 15, :scale => 2


      t.timestamps
    end
  end
end
