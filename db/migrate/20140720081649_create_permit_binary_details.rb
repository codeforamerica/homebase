class CreatePermitBinaryDetails < ActiveRecord::Migration
  def change
    create_table :permit_binary_details do |t|
      t.string :filename
      t.string :content_type
      t.integer :size

      t.timestamps
    end
  end
end
