class Binary < ActiveRecord::Base
  has_many :permit_binary_details
  validates_presence_of :data
  
end
