class AddAcceptedTermsToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :accepted_terms, :boolean
  end
end
