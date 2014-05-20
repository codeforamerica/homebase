class Permit < ActiveRecord::Base
  validates :owner_address,      :presence => true, :if => :active_or_address?

  def active?
    status == 'active'
  end

  def active_or_address?
    status.to_s.include?('enter_address') || active?
  end
end
