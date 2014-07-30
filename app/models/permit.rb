class Permit < ActiveRecord::Base
  has_many :permit_binary_details
  has_many :binaries, through: :permit_binary_details

  # validates on permit_steps#new
  # validates_inclusion_of :addition, :in => [true], :message => "Please choose an improvement."
  validate :at_least_one_chosen

  # validates on permit_steps#enter_address
  validates_presence_of :owner_address, :if => :active_or_address_details?, :message => "Please enter a San Antonio address."
  
  # validates on permit_steps#enter_details
  validates :owner_address, :address => true, :if => :only_if_address_presence?
  validates_presence_of :owner_name, :if => :active_or_details?, :message => "Please enter home owner name."
  validates_presence_of :work_summary, :if => :active_or_details?, :message => "Please enter a work summary."
  validates_presence_of :job_cost, :if => :active_or_details?, :message => "Please enter the job cost."
  #validates :job_cost, :if => :only_if_job_cost_presence?, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :message => "Job cost has an invalid format, it should be like 1000000.00"
  #validates :job_cost, :if => :only_if_job_cost_presence?, :numericality => {:greater_than => 0, :less_than => 1000000000000}, :message => "Job cost should be between the range of 0.00 to 1000000000000.00"
  #validates_numericality_of :job_cost, :if => :only_if_job_cost_presence?, :message => "Job cost must be a number."
  validates_format_of :job_cost, :if => :only_if_job_cost_presence?, :with => /\A\d+(?:\.\d{0,2})?\z/, :message => "Job cost has an invalid format, it should be like 1000000.00"
  validates_numericality_of :job_cost, :if => :only_if_job_cost_presence?, :greater_than => 0, :less_than => 1000000000000 , :message => "Job cost should be between the range of 0.00 to 1000000000000.00"  
  # validates on permit_steps#enter_addition
  validates_presence_of :house_area, :if => :active_or_details_addition?, :message => "Please enter the size of house in square feet."
  validates_numericality_of :house_area, :if => :only_if_house_presence?, :message => "Please enter the size of house in square feet."
  validates_presence_of :addition_area, :if => :active_or_details_addition?, :message => "Please enter the size of addition in square feet."
  validates_numericality_of :addition_area, :if => :only_if_addition_presence?, :message => "Please enter the size of addition in square feet."
  validates_numericality_of :addition_area, less_than: 1000, :if => :only_if_addition_presence?, :message => "Addition must be less than 1,000 Square Feet."
  validates_presence_of :ac, :if => :active_or_details_addition?, :message => "Please select an air conditioning / heating system."
  validates_format_of :email, :if => :active_or_details?, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Please enter your valid email address (for example, john@email.com)"
  validates_format_of :phone, :if => :active_or_details?, :with => /\A(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}\z/i, :message => "Please enter a valid phone number (for example, 210-555-5555)"

  # validates on permit_steps#enter_repair
  validates_numericality_of :window_count, greater_than: 0, :if => :only_if_window_true?, :message => "Please specify the number of windows you are repairing."
  validates_numericality_of :door_count, greater_than: 0, :if=> :only_if_door_true?, :message => "Please specify the number of doors you are repairing."

  def active?
    status == 'active'
  end

  def active_or_address_details?
    status.to_s.include?('enter_address') || 
    status.to_s.include?('enter_details') || 
    active?
  end

  def only_if_address_presence?
    active_or_address_details? && ! owner_address.blank?
  end

  def active_or_details?
    status.to_s.include?('enter_details') || active?
  end

  def active_or_details_addition?
    active_or_details? && addition
  end

  def only_if_addition_presence?
    active_or_details_addition? && ! addition_area.blank?
  end

  def only_if_house_presence?
    active_or_details_addition? && ! house_area.blank?
  end

  def only_if_job_cost_presence?
    active_or_details? && ! job_cost.blank?
  end

  def only_if_window_true?
    active_or_details? && window
  end

  def only_if_door_true?
    active_or_details? && door
  end

  def at_least_one_chosen
    if !(addition || window || door || wall || siding || floor || cover || pool || deck || acs_struct)
      errors[:base] << ("Please choose at least one project to work on.")
    end
  end
end
