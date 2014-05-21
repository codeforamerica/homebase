class Permit < ActiveRecord::Base
  validates :owner_address, :presence => true, :if => :active_or_address?
  validates :owner_address, :address => true, :if => :only_if_presence?


  def active?
    status == 'active'
  end

  def active_or_address?
    status.to_s.include?('enter_address') || active?
  end

  def only_if_presence?
    active_or_address? && ! owner_address.blank?
  end
end
