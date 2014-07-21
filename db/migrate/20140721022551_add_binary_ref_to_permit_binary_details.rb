class AddBinaryRefToPermitBinaryDetails < ActiveRecord::Migration
  def change
    add_reference :permit_binary_details, :binary, index: true
  end
end
