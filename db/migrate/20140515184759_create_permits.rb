class CreatePermits < ActiveRecord::Migration
  def change
    create_table :permits do |t|
      t.string :owner_name
      t.string :owner_address
      t.boolean :addition
      t.integer :house_area
      t.integer :addition_area
      t.string :ac
      t.boolean :contractor
      t.string :contractor_name
      t.string :contractor_id
      t.boolean :escrow
      t.string :license_holder
      t.string :license_num
      t.string :agent_name
      t.string :contact_id
      t.string :other_contact_id
      t.string :phone
      t.string :fax
      t.string :email
      t.text :work_summary

      t.timestamps
    end
  end
end
