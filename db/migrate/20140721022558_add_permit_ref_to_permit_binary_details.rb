class AddPermitRefToPermitBinaryDetails < ActiveRecord::Migration
  def change
    add_reference :permit_binary_details, :permit, index: true
  end
end
