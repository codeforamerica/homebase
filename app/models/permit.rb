class Permit < ActiveRecord::Base
  has_many :permit_binary_details
  has_many :binaries, through: :permit_binary_details

  attr_accessor 
                # User selected projects
                :selected_addition,
                :selected_acs_struct,
                :selected_deck,
                :selected_pool,
                :selected_cover,
                :selected_window,
                :selected_door,
                :selected_wall,
                :selected_siding,
                :selected_floor,

                :confirmed_name,

                # Room Addition
                :addition_size, :addition_num_story,
                # Accessory Structure
                :acs_struct_size, :acs_struct_num_story,
                # Deck
                :deck_size, :deck_grade, :deck_dwelling_attach, :deck_exit_door,
                # Pool
                :pool_location, :pool_volume,
                # Cover
                :cover_material,
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

  ADDITION_SIZE_OPTIONS = { 'lessThan1000' => "Less than 1,000 sq ft", 'greaterThanEqualTo1000' => "Greater than or equal to 1,000 sq ft" }
  ADDITION_NUM_STORY_OPTIONS = { '1Story' => "1 Story", '2orMoreStories' => "2 or more stories" }

  ACS_STRUCT_SIZE_OPTIONS = { 'lessThanEqualTo120' => "Less than or equal to 120 sq ft", 'greaterThan120' => "Greater than 120 sq ft" }
  ACS_STRUCT_NUM_STORY_OPTIONS = { '1Story' => "1 Story", '2orMoreStories' => "2 or more stories" }

  DECK_SIZE_OPTIONS = {'lessThanEqualTo120' => "Less than or equal to 120 sq ft", 'greaterThan120' => "Greater than 120 sq ft" }
  DECK_GRADE_OPTIONS = {'lessThanEqualTo30' => "Less than or equal to 30 inches above grade", 'moreThan30' => "More than 30 inches above grade" }
  DECK_DWELLING_ATTACH_OPTIONS = {'attachedToDwelling' => "Attached to dwelling", 'notAttachedToDwelling' => "Not attached to dwelling" }
  DECK_EXIT_DOOR_OPTIONS = {'exitDoor' => "Serves a required exit door", 'noExitDoor' => "Does not serve a required exit door" }

  POOL_LOCATION_OPTIONS = {'inGround' => "Pool is in ground", 'aboveGround' => "Pool is above ground" }
  POOL_VOLUME_OPTIONS = {'lessThanEqualTo5000' => "Less than or equal to 5,000 gallons", 'moreThan5000' => "More than 5,000 gallons" }

  COVER_MATERIAL_OPTIONS = {'metalType2' => "It's metal type II", 'woodType5' => "It's wood type V", 'other' => "Other" }

  # validates on permit_steps#new
  # validates_inclusion_of :addition, :in => [true], :message => "Please choose an improvement."
  validate :at_least_one_chosen

  # validates on permit_steps#answer_screener
  validates_presence_of :addition_size, :if => :only_if_screener_addition?, :message => "Please select the size of the room addition."
  validates_presence_of :addition_num_story, :if => :only_if_screener_addition?, :message => "Please select the number of stories for the room addition."

  validates_presence_of :acs_struct_size, :if => :only_if_screener_acs_struct?, :message => "Please select the size of the accessory structure."
  validates_presence_of :acs_struct_num_story, :if => :only_if_screener_acs_struct?, :message => "Please select the number of stories for the accessory structure."

  validates_presence_of :deck_size, :if => :only_if_screener_deck?, :message => "Please select the size of the deck."
  validates_presence_of :deck_grade, :if => :only_if_screener_deck?, :message => "Please select the grade of the deck."
  validates_presence_of :deck_dwelling_attach, :if => :only_if_screener_deck?, :message => "Please select whether the deck is attached to dwelling or not."
  validates_presence_of :deck_exit_door, :if => :only_if_screener_deck?, :message => "Please select whether the deck serves a required exit door or not."

  validates_presence_of :pool_location, :if => :only_if_screener_pool?, :message => "Please select whether the swimming pool is in ground or above ground."
  validates_presence_of :pool_volume, :if => :only_if_screener_pool?, :message => "Please select the volume of the swimming pool."

  validates_presence_of :cover_material, :if => :only_if_screener_cover?, :message => "Please select the material for the carport, patio cover, or porch cover."

  validates_presence_of :window_replace_glass, :if => :only_if_screener_window?, :message => "Please select whether you are only replacing broken glass or not."
  
  validates_presence_of :door_replace_existing, :if => :only_if_screener_door?, :message => "Please select whether you are only replacing doors on their existing hinges or not."
  
  validates_presence_of :wall_general_changes, :if => :only_if_screener_wall?, :message => "Please select whether you are only doing paint, wallpaper, or repairing sheetrock without moving or altering studs."
  
  validates_presence_of :siding_over_existing, :if => :only_if_screener_siding?, :message => "Please select whether you are only placing new siding over existing siding or not."
  
  validates_presence_of :floor_covering, :if => :only_if_screener_floor?, :message => "Please select whether you are only doing floor covering such as carpet, tile, wood/laminate flooring or not."

  validates_presence_of :owner_address, :if => :active_or_screener_details?, :message => "Please enter a San Antonio address."
  
  # validates on permit_steps#enter_details
  validates :owner_address, :address => true, :if => :only_if_address_presence?
  validates_presence_of :owner_name, :if => :active_or_details?, :message => "Please enter home owner name."
  validates_inclusion_of :contractor, :in => [true, false], :if => :active_or_details?, :message => "Please select whether you are using a contractor or not in this project."
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

  # validates on permit_steps#enter_repair
  validates_numericality_of :window_count, greater_than: 0, :if => :only_if_window_true?, :message => "Please specify the number of windows you are repairing."
  validates_numericality_of :door_count, greater_than: 0, :if=> :only_if_door_true?, :message => "Please specify the number of doors you are repairing."

  # validates on permit_step#confirm_details
  
  validates_acceptance_of :accepted_terms, :accept => true, :if => :accepted_terms_acceptance?, :message => "Please accept the terms listed here by checking the box below."
  before_save :ensure_name_confirmed, :if => :accepted_terms_acceptance?, :message => "The name didn't validate."



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
    active_or_screener? && selected_addition
  end

  def only_if_screener_acs_struct?
    active_or_screener? && selected_acs_struct
  end

  def only_if_screener_deck?
    active_or_screener? && selected_deck
  end

  def only_if_screener_pool?
    active_or_screener? && selected_pool
  end

  def only_if_screener_cover?
    active_or_screener? && selected_cover
  end

  def only_if_screener_window?
    active_or_screener? && selected_window
  end

  def only_if_screener_door?
    active_or_screener? && selected_door
  end

  def only_if_screener_wall?
    active_or_screener? && selected_wall
  end

  def only_if_screener_siding?
    active_or_screener? && selected_siding
  end

  def only_if_screener_floor?
    active_or_screener? && selected_floor
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
    if !( selected_addition || selected_window || selected_door || 
          selected_wall || selected_siding || selected_floor || 
          selected_cover || selected_pool || selected_deck || 
          selected_acs_struct)

      errors[:base] << ("Please choose at least one project to work on.")
    end
  end

  # Return true if this permit is needed, false if not needed, nil if more guidance will be needed from DSD
  def addition_permit_needed?
    if addition_size.eql? 'lessThan1000' && addition_num_story.eql? '1Story'
      return true
    else
      return nil
    end
  end

  def acs_struct_permit_needed?
    if acs_struct_size.eql? 'greaterThan120' && acs_struct_num_story.eql? '1Story'
      return true
    else
      return nil
    end
  end

  def deck_permit_needed?
    if  deck_size.eql? 'greaterThan120' && 
        deck_grade.eql? 'moreThan30' && 
        deck_dwelling_attach.eql? 'attachedToDwelling' && 
        deck_exit_door.eql? 'exitDoor'
      return true
    else
      return nil
    end
  end

  def pool_permit_needed?
    if pool_location.eql? 'inGround'
      return true
    elsif pool_location.eql? 'aboveGround' && pool_volume.eql? 'moreThan5000'
      return true
    else
      return nil
    end
  end

  def cover_permit_needed?
    if cover_material.eql? 'metalType2'
      return true
    elsif cover_material.eql? 'woodType5'
      return true
    else
      return nil
    end
  end

  def window_permit_needed?
    if window_replace_glass
      return true
    else
      return false
    end
  end

  def door_permit_needed?
    if door_replace_existing
      return true
    else
      return false
    end
  end

  def wall_permit_needed?
    if wall_general_changes
      return true
    else
      return false
    end
  end

  def siding_permit_needed?
    if siding_over_existing
      return true
    else
      return false
    end
  end

  def floor_permit_needed?
    if floor_covering
      return true
    else
      return false
    end
  end

  def update_permit_needs_for_projects
    permit_needs = { :permit_needed => [], :permit_not_needed => [], :further_assistance_needed => [] }

    if selected_addition 

      if addition_permit_needed?
        addition = true
        permit_needs[:permit_needed].push("Addition")
      else
        permit_needs[:further_assistance_needed].push("Addition")
      end

    end

    if selected_acs_struct 

      if acs_struct_permit_needed?
        acs_struct = true
        permit_needs[:permit_needed].push("Shed/Garage")
      else
        permit_needs[:further_assistance_needed].push("Shed/Garage")
      end

    end

    if selected_deck

      if deck_permit_needed?
        deck = true
        permit_needs[:permit_needed].push("Deck")
      else
        permit_needs[:further_assistance_needed].push("Deck")
      end

    end

    if selected_pool

      if pool_permit_needed?
        pool = true
        permit_needs[:permit_needed].push("Swimming Pool")
      else
        permit_needs[:further_assistance_needed].push("Swimming Pool")
      end

    end

    if selected_cover

      if cover_permit_needed?
        cover = true
        permit_needs[:permit_needed].push("Carport/Outdoor Cover")
      else
        permit_needs[:further_assistance_needed].push("Carport/Outdoor Cover")
      end

    end

    if selected_window

      if window_permit_needed?
        window = true
        permit_needs[:permit_needed].push("Windows")
      else
        permit_needs[:permit_not_needed].push("Windows")
      end

    end

    if selected_door
      if door_permit_needed?
        door = true
        permit_needs[:permit_needed].push("Doors")
      else
        permit_needs[:permit_not_needed].push("Doors")
      end

    end

    if selected_wall
      if wall_permit_needed?
        wall = true
        permit_needs[:permit_needed].push("Walls")
      else
        permit_needs[:permit_not_needed].push("Walls")
      end

    end

    if selected_siding

      if siding_permit_needed?
        siding = true
        permit_needs[:permit_needed].push("Replace Siding")
      else
        permit_needs[:permit_not_needed].push("Replace Siding")
      end

    end

    if selected_floor
      if floor_permit_needed?
        floor = true
        permit_needs[:permit_needed].push("Floors")
      else
        permit_needs[:permit_not_needed].push("Floors")
      end

    end

    return permit_needs
  end

end
