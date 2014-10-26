class Project < ActiveRecord::Base 
  has_many :permit_binary_details
  has_many :binaries, through: :permit_binary_details
  has_one :general_repair_permit

  accepts_nested_attributes_for :general_repair_permit
  include ActiveModel::Validations
  

  ######## Virtual Attributes ########
           
  attr_accessor :confirmed_name
  
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
  validates_presence_of :addition_num_story, :if => :only_if_screener_addition?

  # Accessory Structure Section
  validates_presence_of :acs_struct_size, :if => :only_if_screener_acs_struct?
  validates_presence_of :acs_struct_num_story, :if => :only_if_screener_acs_struct?

  # Deck Section
  validates_presence_of :deck_size, :if => :only_if_screener_deck?
  validates_presence_of :deck_grade, :if => :only_if_screener_deck?
  validates_presence_of :deck_dwelling_attach, :if => :only_if_screener_deck?
  validates_presence_of :deck_exit_door, :if => :only_if_screener_deck?

  # Pool Section
  validates_presence_of :pool_location, :if => :only_if_screener_pool?
  validates_presence_of :pool_volume, :if => :only_if_screener_pool?

  # Window Section
  validates_presence_of :window_replace_glass, :if => :only_if_screener_window?
  
  # Door Section
  validates_presence_of :door_replace_existing, :if => :only_if_screener_door?
  
  # Wall Section
  validates_presence_of :wall_general_changes, :if => :only_if_screener_wall?
  
  # Siding Section
  validates_presence_of :siding_over_existing, :if => :only_if_screener_siding?
  
  # Floor Section
  validates_presence_of :floor_covering, :if => :only_if_screener_floor?

  # Contractor Section
  validates_inclusion_of :contractor, :in => [true, false], :if => :active_or_screener?

  # Home Address Section
  validates_presence_of :owner_address, :if => :active_or_screener_details?
  validates_with AddressValidator, :if => :only_if_address_presence?
  
  ## Validations on permit_steps#enter_details ##

  # Basic Information Section
  validates_presence_of :owner_name, :if => :active_or_details?
  # Validator for owner_address above at permit_steps#answer_screener
  validates_format_of :email, :if => :active_or_details?, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_format_of :phone, :if => :active_or_details?, :with => /\A(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}\z/i

  # Addition Section # @TODO: move to general repair permits
  # validates_presence_of :house_area, :if => :active_or_details_addition?
  # validates_numericality_of :house_area, :if => :only_if_house_presence?
  # validates_presence_of :addition_area, :if => :active_or_details_addition?
  # validates_numericality_of :addition_area, :if => :only_if_addition_presence?
  # validates_numericality_of :addition_area, less_than: 1000, :if => :only_if_addition_presence?
  # validates_presence_of :ac, :if => :active_or_details_addition?

  # Window Section # @TODO: move to general repair permits
  # validates_numericality_of :window_count, greater_than: 0, :if => :only_if_window_true?
  
  # Door Section # @TODO: move to general repair permits
  # validates_numericality_of :door_count, greater_than: 0, :if=> :only_if_door_true?

  # Final Info Section @TODO: move to general repair permits
  # validates_presence_of :work_summary, :if => :active_or_details?
  # validates_presence_of :job_cost, :if => :active_or_details?
  # validates_format_of :job_cost, :if => :only_if_job_cost_presence?, :with => /\A\d+(?:\.\d{0,2})?\z/
  # validates_numericality_of :job_cost, :if => :only_if_job_cost_presence?, :greater_than => 0, :less_than => 1000000000000

  ## Validations on permit_step#confirm_terms ## @TODO: move to general repair permits

  # validates_acceptance_of :accepted_terms, :accept => true, :if => :accepted_terms_acceptance?
  # before_save :ensure_name_confirmed, :if => :accepted_terms_acceptance?, :message => I18n.t('models.project.ensure_name_confirmed_msg')

  # @TODO: may want to do this instead of before_save
  # class Person < ActiveRecord::Base
  #   validates :email, confirmation: true
  #   validates :email_confirmation, presence: true
  # end
  ######## Attribute Options Hashes ########

  # Projects
  def addition_details
    { :addition_size => { label:    I18n.t('models.project.addition.size.label'), 
                          options:  [ { value: 'lessThan1000', label: I18n.t('models.project.addition.size.options.lt_1000') }, 
                                      { value: 'greaterThanEqualTo1000',  label: I18n.t('models.project.addition.size.options.gte_1000')}]},
      :addition_num_story =>  { label:    I18n.t('models.project.addition.num_story.label'),
                                options:  [ { value: '1Story', label: I18n.t('models.project.addition.num_story.options.one') }, 
                                            { value: '2orMoreStories', label: I18n.t('models.project.addition.num_story.options.two_or_more') }]}}
  end

  def acs_struct_details
    { :acs_struct_size =>  {  label:    I18n.t('models.project.acs_struct.size.label'),
                              options:  [ { value: 'lessThanEqualTo120', label: I18n.t('models.project.acs_struct.size.options.lte_120') }, 
                                          { value: 'greaterThan120', label: I18n.t('models.project.acs_struct.size.options.gt_120') }]},
      :acs_struct_num_story => {  label:     I18n.t('models.project.acs_struct.num_story.label'),
                                  options:  [ { value: '1Story', label: I18n.t('models.project.acs_struct.num_story.options.one') }, 
                                              { value: '2orMoreStories', label: I18n.t('models.project.acs_struct.num_story.options.two_or_more') }]}}

  end

  def deck_details
    { :deck_size => { label:    I18n.t('models.project.deck.size.label'),
                      options:  [ { value: 'lessThanEqualTo200', label: I18n.t('models.project.deck.size.options.lte_200') },
                                  { value: 'greaterThan200', label: I18n.t('models.project.deck.size.options.gt_200') }]},
      :deck_grade => {  label:    I18n.t('models.project.deck.grade.label'),
                        options:  [ { value: 'lessThanEqualTo30', label: I18n.t('models.project.deck.grade.options.lte_30')},
                                    { value: 'moreThan30', label: I18n.t('models.project.deck.grade.options.gt_30')}]},
      :deck_dwelling_attach => {  label:    I18n.t('models.project.deck.dwelling_attach.label'),
                                  options:  [ { value: 'attachedToDwelling', label: I18n.t('models.project.deck.dwelling_attach.options.attached')},
                                              { value: 'notAttachedToDwelling', label: I18n.t('models.project.deck.dwelling_attach.options.not_attached')}]},
      :deck_exit_door => {  label:    I18n.t('models.project.deck.exit_door.label'),
                            options:  [ { value: 'exitDoor', label: I18n.t('models.project.deck.exit_door.options.served')},
                                        { value: 'noExitDoor', label: I18n.t('models.project.deck.exit_door.options.not_served')}]}}
  end

  def pool_details
    { :pool_location => { label:    I18n.t('models.project.pool.location.label'),
                          options:  [ { value: 'inGround', label: I18n.t('models.project.pool.location.options.in_ground')}, 
                                      { value: 'aboveGround', label: I18n.t('models.project.pool.location.options.above_ground') }]},
      :pool_volume => { label:    I18n.t('models.project.pool.volume.label'),
                        options:  [ { value: 'lessThanEqualTo5000', label: I18n.t('models.project.pool.volume.options.lte_5000')}, 
                                    { value: 'moreThan5000', label: I18n.t('models.project.pool.volume.options.gt_5000')}]}}
  end

  # Room Addition
  def ac_options
    [I18n.t('models.project.ac.options.none'), I18n.t('models.project.ac.options.wall'), I18n.t('models.project.ac.options.extended'), I18n.t('models.project.ac.options.split')]
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
    puts "************only_if_screener_addition: #{status.to_s.include?('answer_screener')}, #{to_bool(selected_addition)}"
    puts "addition_size: #{addition_size}"

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
      errors[:confirmed_name] << (I18n.t('models.project.confirmed_name_msg', name: owner_name))
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

      errors[:base] << (I18n.t('models.project.no_proj_chosen_msg'))
    end
  end

  # Formatter

  def create_needed_permits

    if GeneralRepairPermit.is_needed?(self)
      self.general_repair_permit ||= GeneralRepairPermit.new
      if GeneralRepairPermit.addition_permit_needed?(self)
        puts "general_repair_permit.addition: #{general_repair_permit.addition}"
        puts "********************__________Updating addition_________***********"
        update_attributes(general_repair_permit_attributes: {addition: true})

        puts "********************__________Updated addition_________***********"
        puts "general_repair_permit.addition: #{general_repair_permit.addition}"
      end
      if GeneralRepairPermit.acs_struct_permit_needed?(self)
        update_attributes(general_repair_permit_attributes: {acs_struct: true})
      end
      if GeneralRepairPermit.deck_permit_needed?(self)
        update_attributes(general_repair_permit_attributes: {deck: true})
      end
      if GeneralRepairPermit.pool_permit_needed?(self)
        update_attributes(general_repair_permit_attributes: {pool: true})
      end
      if GeneralRepairPermit.cover_permit_needed?(self)
        update_attributes(general_repair_permit_attributes: {cover: true})
      end
      if GeneralRepairPermit.window_permit_needed?(self)
        update_attributes(general_repair_permit_attributes: {window: true})
      end
      if GeneralRepairPermit.door_permit_needed?(self)
        update_attributes(general_repair_permit_attributes: {door: true})
      end
      if GeneralRepairPermit.wall_permit_needed?(self)
        update_attributes(general_repair_permit_attributes: {wall: true})
      end
      if GeneralRepairPermit.siding_permit_needed?(self)
        update_attributes(general_repair_permit_attributes: {siding: true})
      end
      if GeneralRepairPermit.floor_permit_needed?(self)
        update_attributes(general_repair_permit_attributes: {floor: true})
      end
      # Add more subproject check
    end

    # Add more permits

  end

  # Output: {general_repair_permit => {addition => true, door => true}, historical_form => {addition => true, door => false}}
  def get_require_permits_for_subprojects
    response = {}
    response[:general_repair_permit] = GeneralRepairPermit.subprojects_needs(self)
    # Add more forms and permits here
    # response[:name_of_permit] = PermitClass.is_needed?(self)

    return response
  end 

  # Input:  {general_repair_permit => {addition => true, door => true}, historical_form => {addition => true, door => false}}, true
  # Output: [addition, door]
  # Input:  {general_repair_permit => {addition => true, door => true}, historical_form => {addition => true, door => false}}, false
  # Output: [door]
  def self.get_subprojects_permit_needed(required_permits, permit_needed_check)
    response = []
    required_permits.each do | permit, subproject_pair |
      subproject_pair.each do | subproject, permit_needed |
        if permit_needed == permit_needed_check
          response.push("models.project.#{subproject.to_s.sub('selected_', '')}.name")
        end
      end
    end
    return response.uniq
  end

  # Input: {general_repair_permit => {addition => true, door => true}, historical_form => {addition => true, door => false}}
  # Output: { general_repair_permit => {addition, door}, historical_form => {addition}}
  def self.get_permits_to_subprojects(required_permits)
    response = {}
    required_permits.each do | permit, subproject_pair |
      subproject_pair.each do | subproject, permit_needed |
        if permit_needed == true
          if response[permit] == nil
            response[permit] = []
          end
          response[permit].push(subproject)
        end
      end
    end
    return response
  end

  def get_permit_needed_info
    response = {}
    response[:required_permits] = get_require_permits_for_subprojects
    # @TODO: May need to manipulate if something in permit_needed, should it be in not_permit, what about if
    # something needs further assistance, do I still apply for permit?
    response[:permit_needed] = self.class.get_subprojects_permit_needed(response[:required_permits], true)
    response[:permit_not_needed] = self.class.get_subprojects_permit_needed(response[:required_permits], false)
    response[:further_assistance_needed] = self.class.get_subprojects_permit_needed(response[:required_permits], nil)
    #response[:subproject_to_permits] = self.class.get_subproject_to_permits
    response[:permits_to_subprojects] = self.class.get_permits_to_subprojects(response[:required_permits])
    return response

    # permit_not_needed only if it doesn't exist in permit_needed or further_assistance_needed


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
