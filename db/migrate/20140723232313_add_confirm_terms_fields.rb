class AddConfirmTermsFieldsToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :confirmed_name, :string
    add_column :permits, :accepted_terms, :boolean
  end
end
