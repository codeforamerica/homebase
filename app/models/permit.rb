class Permit < ActiveRecord::Base 
  has_many :permit_binary_details
  has_many :binaries, through: :permit_binary_details

 
  include ActiveModel::Validations
  

  ######## Virtual Attributes ########

                # User selected projects
  attr_accessor :selected_addition,
                :selected_acs_struct,
                :selected_deck,
                :selected_pool,
                :selected_cover,
                :selected_window,
                :selected_door,
                :selected_wall,
                :selected_siding,
                :selected_floor,

                #:contractor,
                
                :confirmed_name,

                # Room Addition
                :addition_size, :addition_num_story,
                # Accessory Structure
                :acs_struct_size, :acs_struct_num_story,
                # Deck
                :deck_size, :deck_grade, :deck_dwelling_attach, :deck_exit_door,
                # Pool
                :pool_location, :pool_volume,
                # Window
                :window_replace_glass,
                # Door
                :door_replace_existing,
                # Wall
                :wall_general_changes,
                # Siding
                :siding_over_existing,
                # Floor
                :floor_covering












  
  ######## Validations #######

  # @TODO: Should I group these in terms of each view, should model have an idea of how the views look like

  ## Validations on permit_steps#new ##

  before_validation(on: :create) do
    projects_to_bool
  end
  validate :at_least_one_chosen, :if => :first_step?

  ## Validations on permit_steps#answer_screener ##

  # Addition Section
  validates_presence_of :addition_size, :if => :only_if_screener_addition?
  validates_presence_of :addition_num_story, :if => :only_if_screener_addition?, :message => "Please select the number of stories for the room addition."

  # Accessory Structure Section
  validates_presence_of :acs_struct_size, :if => :only_if_screener_acs_struct?, :message => "Please select the size of the accessory structure."
  validates_presence_of :acs_struct_num_story, :if => :only_if_screener_acs_struct?, :message => "Please select the number of stories for the accessory structure."

  # Deck Section
  validates_presence_of :deck_size, :if => :only_if_screener_deck?, :message => "Please select the size of the deck."
  validates_presence_of :deck_grade, :if => :only_if_screener_deck?, :message => "Please select the grade of the deck."
  validates_presence_of :deck_dwelling_attach, :if => :only_if_screener_deck?, :message => "Please select whether the deck is attached to dwelling or not."
  validates_presence_of :deck_exit_door, :if => :only_if_screener_deck?, :message => "Please select whether the deck serves a required exit door or not."

  # Pool Section
  validates_presence_of :pool_location, :if => :only_if_screener_pool?, :message => "Please select whether the swimming pool is in ground or above ground."
  validates_presence_of :pool_volume, :if => :only_if_screener_pool?, :message => "Please select the volume of the swimming pool."

  # Window Section
  validates_presence_of :window_replace_glass, :if => :only_if_screener_window?, :message => "Please select whether you are only replacing broken glass or not."
  
  # Door Section
  validates_presence_of :door_replace_existing, :if => :only_if_screener_door?, :message => "Please select whether you are only replacing doors on their existing hinges or not."
  
  # Wall Section
  validates_presence_of :wall_general_changes, :if => :only_if_screener_wall?, :message => "Please select whether you are only doing paint, wallpaper, or repairing sheetrock without moving or altering studs."
  
  # Siding Section
  validates_presence_of :siding_over_existing, :if => :only_if_screener_siding?, :message => "Please select whether you are only placing new siding over existing siding or not."
  
  # Floor Section
  validates_presence_of :floor_covering, :if => :only_if_screener_floor?, :message => "Please select whether you are only doing floor covering such as carpet, tile, wood/laminate flooring or not."

  # Contractor Section
  validates_inclusion_of :contractor, :in => [true, false], :if => :active_or_screener?, :message => "Please select whether you are using a contractor or not in this project."

  # Home Address Section
  validates_presence_of :owner_address, :if => :active_or_screener_details?, :message => "Please enter a San Antonio address."
  validates_with AddressValidator, :if => :only_if_address_presence?
  
  ## Validations on permit_steps#enter_details ##

  # Basic Information Section
  validates_presence_of :owner_name, :if => :active_or_details?, :message => "Please enter home owner name."
  # Validator for owner_address above at permit_steps#answer_screener
  validates_format_of :email, :if => :active_or_details?, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Please enter your valid email address (for example, john@email.com)"
  validates_format_of :phone, :if => :active_or_details?, :with => /\A(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}\z/i, :message => "Please enter a valid phone number (for example, 210-555-5555)"

  # Addition Section
  validates_presence_of :house_area, :if => :active_or_details_addition?, :message => "Please enter the size of house in square feet."
  validates_numericality_of :house_area, :if => :only_if_house_presence?, :message => "Please enter the size of house in square feet."
  validates_presence_of :addition_area, :if => :active_or_details_addition?, :message => "Please enter the size of addition in square feet."
  validates_numericality_of :addition_area, :if => :only_if_addition_presence?, :message => "Please enter the size of addition in square feet."
  validates_numericality_of :addition_area, less_than: 1000, :if => :only_if_addition_presence?, :message => "Addition must be less than 1,000 Square Feet."
  validates_presence_of :ac, :if => :active_or_details_addition?, :message => "Please select an air conditioning / heating system."

  # Window Section
  validates_numericality_of :window_count, greater_than: 0, :if => :only_if_window_true?, :message => "Please specify the number of windows you are repairing."
  
  # Door Section
  validates_numericality_of :door_count, greater_than: 0, :if=> :only_if_door_true?, :message => "Please specify the number of doors you are repairing."

  # Final Info Section
  validates_presence_of :work_summary, :if => :active_or_details?, :message => "Please enter a work summary."
  validates_presence_of :job_cost, :if => :active_or_details?, :message => "Please enter the job cost."
  validates_format_of :job_cost, :if => :only_if_job_cost_presence?, :with => /\A\d+(?:\.\d{0,2})?\z/, :message => "Job cost has an invalid format, it should be like 1000000.00"
  validates_numericality_of :job_cost, :if => :only_if_job_cost_presence?, :greater_than => 0, :less_than => 1000000000000 , :message => "Job cost should be between the range of 0.00 to 1000000000000.00"  

  ## Validations on permit_step#confirm_terms ##

  validates_acceptance_of :accepted_terms, :accept => true, :if => :accepted_terms_acceptance?, :message => "Please accept the terms listed here by checking the box below."
  before_save :ensure_name_confirmed, :if => :accepted_terms_acceptance?, :message => "The name didn't validate."

  ######## Attribute Options Hashes ########

  # Projects
  def addition_details
    { :addition_size => { label:    I18n.t('addition.size.label'), 
                          options:  [ { value: 'lessThan1000', label: I18n.t('addition.size.options.lt_1000') }, 
                                      { value: 'greaterThanEqualTo1000',  label: I18n.t('addition.size.options.gte_1000')}]},
      :addition_num_story =>  { label:    I18n.t('addition.num_story.label'),
                                options:  [ { value: '1Story', label: I18n.t('addition.num_story.options.one') }, 
                                            { value: '2orMoreStories', label: I18n.t('addition.num_story.options.two_or_more') }]}}
  end

  def acs_struct_details
    { :acs_struct_size =>  {  label:    I18n.t('acs_struct.size.label'),
                              options:  [ { value: 'lessThanEqualTo120', label: I18n.t('acs_struct.size.options.lte_120') }, 
                                          { value: 'greaterThan120', label: I18n.t('acs_struct.size.options.gt_120') }]},
      :acs_struct_num_story => {  label:     I18n.t('acs_struct.num_story.label'),
                                  options:  [ { value: '1Story', label: I18n.t('acs_struct.num_story.options.one') }, 
                                              { value: '2orMoreStories', label: I18n.t('acs_struct.num_story.options.two_or_more') }]}}

  end

  def deck_details
    { :deck_size => { label:    I18n.t('deck.size.label'),
                      options:  [ { value: 'lessThanEqualTo200', label: I18n.t('deck.size.options.lte_200') },
                                  { value: 'greaterThan200', label: I18n.t('deck.size.options.gt_200') }]},
      :deck_grade => {  label:    I18n.t('deck.grade.label'),
                        options:  [ { value: 'lessThanEqualTo30', label: I18n.t('deck.grade.options.lte_30')},
                                    { value: 'moreThan30', label: I18n.t('deck.grade.options.gt_30')}]},
      :deck_dwelling_attach => {  label:    I18n.t('deck.dwelling_attach.label'),
                                  options:  [ { value: 'attachedToDwelling', label: I18n.t('deck.dwelling_attach.options.attached')},
                                              { value: 'notAttachedToDwelling', label: I18n.t('deck.dwelling_attach.options.not_attached')}]},
      :deck_exit_door => {  label:    I18n.t('deck.exit_door.label'),
                            options:  [ { value: 'exitDoor', label: I18n.t('deck.exit_door.options.served')},
                                        { value: 'noExitDoor', label: I18n.t('deck.exit_door.options.not_served')}]}}
  end

  def pool_details
    { :pool_location => { label:    I18n.t('pool.location.label'),
                          options:  [ { value: 'inGround', label: I18n.t('pool.location.options.in_ground')}, 
                                      { value: 'aboveGround', label: I18n.t('pool.location.options.above_ground') }]},
      :pool_volume => { label:    I18n.t('pool.volume.label'),
                        options:  [ { value: 'lessThanEqualTo5000', label: I18n.t('pool.volume.options.lte_5000')}, 
                                    { value: 'moreThan5000', label: I18n.t('pool.volume.options.gt_5000')}]}}
  end

  # Room Addition
  def ac_options
    [I18n.t('ac.options.none'), I18n.t('ac.options.wall'), I18n.t('ac.options.extended'), I18n.t('ac.options.split')]
  end

  ######## Conditions for Validation ########
  def first_step?
    status == nil
  end

  def active?
    status == 'active'
  end

  def active_or_screener_details?
    status.to_s.include?('answer_screener') || 
    status.to_s.include?('enter_details') || 
    active?
  end

  def active_or_screener?
    status.to_s.include?('answer_screener') || active?
  end

  def only_if_screener_addition?
    status.to_s.include?('answer_screener') && to_bool(selected_addition)
  end

  def only_if_screener_acs_struct?
    status.to_s.include?('answer_screener') && to_bool(selected_acs_struct)
  end

  def only_if_screener_deck?
    status.to_s.include?('answer_screener') && to_bool(selected_deck)
  end

  def only_if_screener_pool?
    status.to_s.include?('answer_screener') && to_bool(selected_pool)
  end

  def only_if_screener_cover?
    status.to_s.include?('answer_screener') && to_bool(selected_cover)
  end

  def only_if_screener_window?
    status.to_s.include?('answer_screener') && to_bool(selected_window)
  end

  def only_if_screener_door?
    status.to_s.include?('answer_screener') && to_bool(selected_door)
  end

  def only_if_screener_wall?
    status.to_s.include?('answer_screener') && to_bool(selected_wall)
  end

  def only_if_screener_siding?
    status.to_s.include?('answer_screener') && to_bool(selected_siding)
  end

  def only_if_screener_floor?
    status.to_s.include?('answer_screener') && to_bool(selected_floor)
  end

  def only_if_address_presence?
    active_or_screener_details? && ! owner_address.blank?
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

  def ensure_name_confirmed
    if !confirmed_name.eql?(owner_name)
      errors[:confirmed_name] << ("The name you entered did not match the name you used on your permit application (#{owner_name}). Please type your name again.")
    end
    confirmed_name.eql?(owner_name)
  end

  def accepted_terms_acceptance?
    status.to_s.include?('confirm_terms') || active?
  end

  def at_least_one_chosen
    if !( to_bool(selected_addition) || to_bool(selected_window) || to_bool(selected_door) || 
          to_bool(selected_wall) || to_bool(selected_siding) || to_bool(selected_floor) || 
          to_bool(selected_cover) || to_bool(selected_pool) || to_bool(selected_deck) || 
          to_bool(selected_acs_struct))

      errors[:base] << ("Please choose at least one project to work on.")
    end
  end

  
  ########  Business Logic for when Permit is needed ########

  # Return true if this permit is needed, false if not needed, nil if more guidance will be needed from DSD
  def addition_permit_needed?
    if addition_size.eql?("lessThan1000") && addition_num_story.eql?("1Story")
      return true
    else
      return nil
    end
  end

  def acs_struct_permit_needed?
    if acs_struct_size.eql?('greaterThan120') && acs_struct_num_story.eql?('1Story')
      return true
    elsif acs_struct_size.eql?('lessThanEqualTo120') && acs_struct_num_story.eql?('1Story')
      return false
    else
      return nil
    end
  end

  def deck_permit_needed?
    if  deck_size.eql?('lessThanEqualTo200') && 
        deck_grade.eql?('lessThanEqualTo30') && 
        deck_dwelling_attach.eql?('notAttachedToDwelling') && 
        deck_exit_door.eql?('noExitDoor')
      return false
    else
      return true
    end
  end

  def pool_permit_needed?
    if pool_location.eql?('inGround')
      return true
    elsif pool_location.eql?('aboveGround') && pool_volume.eql?('moreThan5000')
      return true
    elsif pool_location.eql?('aboveGround') && pool_volume.eql?('lessThanEqualTo5000')
      return false
    else
      return nil
    end
  end

  def cover_permit_needed?
    return true
  end

  def window_permit_needed?
    if to_bool(window_replace_glass)
      return false
    else
      return true
    end
  end

  def door_permit_needed?
    if to_bool(door_replace_existing)
      return false
    else
      return true
    end
  end

  def wall_permit_needed?
    if to_bool(wall_general_changes)
      return false
    else
      return true
    end
  end

  def siding_permit_needed?
    if to_bool(siding_over_existing)
      return false
    else
      return true
    end
  end

  def floor_permit_needed?
    if to_bool(floor_covering)
      return false
    else
      return true
    end
  end

  def update_permit_needs_for_projects
    permit_needs = { "permit_needed" => [], "permit_not_needed" => [], "further_assistance_needed" => [] }

    if to_bool(selected_addition) 

      if addition_permit_needed?
        permit_needs["permit_needed"].push("Addition")
        update_attribute("addition", true)
      else
        permit_needs["further_assistance_needed"].push("Addition")
        update_attribute("addition", nil)
      end

    end

    ####### Helpers Methods to change virtual attributes values to booleans ########
    # @TODO: Check if these are necessary anymore

    if to_bool(selected_acs_struct)

      if acs_struct_permit_needed?
        permit_needs["permit_needed"].push("Shed/Garage")
        update_attribute("acs_struct", true)
      elsif acs_struct_permit_needed? == false
        permit_needs["permit_not_needed"].push("Shed/Garage")
      else
        permit_needs["further_assistance_needed"].push("Shed/Garage")
        update_attribute("acs_struct", nil)
      end

    end

    if to_bool(selected_deck)

      if deck_permit_needed?
        permit_needs["permit_needed"].push("Deck")
        update_attribute("deck", true)
      elsif deck_permit_needed? == false
        permit_needs["permit_not_needed"].push("Deck")
      else
        permit_needs["further_assistance_needed"].push("Deck")
        update_attribute("deck", nil)
      end

    end

    if to_bool(selected_pool)

      if pool_permit_needed?
        permit_needs["permit_needed"].push("Swimming Pool")
        update_attribute("pool", true)
      elsif pool_permit_needed? == false
        permit_needs["permit_not_needed"].push("Swimming Pool")
        update_attribute("pool", false)
      else
        permit_needs["further_assistance_needed"].push("Swimming Pool")
        update_attribute("pool", nil)
      end

    end

    if to_bool(selected_cover)

      if cover_permit_needed?
        permit_needs["permit_needed"].push("Carport/Outdoor Cover")
        update_attribute("cover", true)
      else
        permit_needs["further_assistance_needed"].push("Carport/Outdoor Cover")
        update_attribute("cover", nil)
      end

    end

    if to_bool(selected_window)

      if window_permit_needed?
        permit_needs["permit_needed"].push("Windows")
        update_attribute("window", true)
      else
        permit_needs["permit_not_needed"].push("Windows")
        update_attribute("window", false)
      end

    end

    if to_bool(selected_door)
      if door_permit_needed?
        permit_needs["permit_needed"].push("Doors")
        update_attribute("door", true)
      else
        permit_needs["permit_not_needed"].push("Doors")
        update_attribute("door", false)
      end

    end

    if to_bool(selected_wall)
      if wall_permit_needed?
        permit_needs["permit_needed"].push("Walls")
        update_attribute("wall", true)
      else
        permit_needs["permit_not_needed"].push("Walls")
        update_attribute("wall", false)
      end

    end

    if to_bool(selected_siding)

      if siding_permit_needed?
        permit_needs["permit_needed"].push("Replace Siding")
        update_attribute("siding", true)
      else
        permit_needs["permit_not_needed"].push("Replace Siding")
        update_attribute("siding", false)
      end

    end

    if to_bool(selected_floor)
      if floor_permit_needed?
        permit_needs["permit_needed"].push("Floors")
        update_attribute("floor", true)
      else
        permit_needs["permit_not_needed"].push("Floors")
        update_attribute("floor", false)
      end

    end


    return permit_needs
  end

  def to_bool(value)
    if value == "1" || value == 1 || value == true || value == "true"
      return true
    else
      return false
    end
  end
    
  def projects_to_bool
    selected_addition = to_bool(selected_addition)
    selected_acs_struct = to_bool(selected_acs_struct)
    selected_deck = to_bool(selected_deck)
    selected_pool = to_bool(selected_pool)
    selected_cover = to_bool(selected_cover)
    selected_window = to_bool(selected_window)
    selected_door = to_bool(selected_door)
    selected_wall = to_bool(selected_wall)
    selected_siding = to_bool(selected_siding)
    selected_floor = to_bool(selected_floor)

    return nil
  end


end
