class Permit < ActiveRecord::Base
  validates_presence_of :owner_address, :if => :active_or_address?, :message => "Please enter a San Antonio address."
  validates :owner_address, :address => true, :if => :only_if_presence?
  validates_numericality_of :addition_area, less_than: 1000, :if => :active_or_details?, :message => "Addition cannot be larger than 1000 Square Feet."


  def active?
    status == 'active'
  end

  def active_or_address?
    status.to_s.include?('enter_address') || active?
  end

  def only_if_presence?
    active_or_address? && ! owner_address.blank?
  end

  def active_or_details?
    status.to_s.include?('enter_details') || active?
  end
end
