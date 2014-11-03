class GeneralRepairPermit < ActiveRecord::Base
  belongs_to :project

  ######## Virtual Attributes ########
           
  attr_accessor :confirmed_name

  # Addition Section # @TODO: move to general repair permits
  validates_presence_of :house_area, :if => :project_active_or_details_addition?
  validates_numericality_of :house_area, :if => :only_if_house_presence?
  validates_presence_of :addition_area, :if => :project_active_or_details_addition?
  validates_numericality_of :addition_area, :if => :only_if_addition_presence?
  validates_numericality_of :addition_area, less_than: 1000, :if => :only_if_addition_presence?
  validates_presence_of :ac, :if => :project_active_or_details_addition?

  # Window Section # @TODO: move to general repair permits
  validates_numericality_of :window_count, greater_than: 0, :if => :only_if_window_true?
  
  # Door Section # @TODO: move to general repair permits
  validates_numericality_of :door_count, greater_than: 0, :if=> :only_if_door_true?

  # Final Info Section @TODO: move to general repair permits
  validates_presence_of :work_summary, :if => :project_active_or_details?
  validates_presence_of :job_cost, :if => :project_active_or_details?
  validates_format_of :job_cost, :if => :only_if_job_cost_presence?, :with => /\A\d+(?:\.\d{0,2})?\z/
  validates_numericality_of :job_cost, :if => :only_if_job_cost_presence?, :greater_than => 0, :less_than => 1000000000000

  ## Validations on permit_step#confirm_terms ## @TODO: move to general repair permits

  validates_acceptance_of :accepted_terms, :accept => true, :if => :accepted_terms_acceptance?
  before_save :ensure_name_confirmed, :if => :accepted_terms_acceptance?, :message => I18n.t('models.general_repair_permit.ensure_name_confirmed_msg')

  def get_project
    project = Project.find_by_id(project_id)
    return project
  end

  def project_active_or_details?
    project = get_project
    result = project && project.status && (project.status.to_s.include?('enter_details') || project.status.to_s.include?('active'))
    return result
  end  

  def only_if_is_needed_enter_details?
    project_active_or_details? && self.class.is_needed?(project)
  end

  def project_active_or_details_addition?
    project_active_or_details? && addition
  end

  def only_if_addition_presence?
    project_active_or_details_addition? && ! addition_area.blank?
  end

  def only_if_house_presence?
    project_active_or_details_addition? && ! house_area.blank?
  end

  def only_if_job_cost_presence?
    project_active_or_details? && ! job_cost.blank?
  end

  def only_if_window_true?
    project_active_or_details? && window
  end

  def only_if_door_true?
    project_active_or_details? && door
  end

  def ensure_name_confirmed
    project = get_project
    cname_is_oname = confirmed_name.eql?(project.owner_name)
    if !cname_is_oname
      errors[:confirmed_name] << (I18n.t('models.general_repair_permit.confirmed_name_msg', name: project.owner_name))
    end
    return cname_is_oname
  end

  def accepted_terms_acceptance?
    project = get_project
    return project && project.status && (project.status.to_s.include?('confirm_terms') || project.status.to_s.include?('active'))
  end
  

  ########  Business Logic for when project is needed ########

  # Return true if this permit is needed, false if not needed, nil if more guidance will be needed from DSD
  def self.addition_permit_needed?(project)
    if project.addition_size.eql?("lessThan1000") && project.addition_num_story.eql?("1Story")
      return true
    else
      return nil
    end
  end

  def self.acs_struct_permit_needed?(project)
    if project.acs_struct_size.eql?('greaterThan120') && project.acs_struct_num_story.eql?('1Story')
      return true
    elsif project.acs_struct_size.eql?('lessThanEqualTo120') && project.acs_struct_num_story.eql?('1Story')
      return false
    else
      return nil
    end
  end

  def self.deck_permit_needed?(project)
    if  project.deck_size.eql?('lessThanEqualTo200') && 
        project.deck_grade.eql?('lessThanEqualTo30') && 
        project.deck_dwelling_attach.eql?('notAttachedToDwelling') && 
        project.deck_exit_door.eql?('noExitDoor')
      return false
    else
      return true
    end
  end

  def self.pool_permit_needed?(project)
    if project.pool_location.eql?('inGround')
      return true
    elsif project.pool_location.eql?('aboveGround') && project.pool_volume.eql?('moreThan5000')
      return true
    elsif project.pool_location.eql?('aboveGround') && project.pool_volume.eql?('lessThanEqualTo5000')
      return false
    else
      return nil
    end
  end

  def self.cover_permit_needed?(project)
    return true
  end

  def self.window_permit_needed?(project)
    if project.window_replace_glass
      return false
    else
      return true
    end
  end

  def self.door_permit_needed?(project)
    if project.door_replace_existing
      return false
    else
      return true
    end
  end

  def self.wall_permit_needed?(project)
    if project.wall_general_changes
      return false
    else
      return true
    end
  end

  def self.siding_permit_needed?(project)
    if project.siding_over_existing
      return false
    else
      return true
    end
  end

  def self.floor_permit_needed?(project)
    if project.floor_covering
      return false
    else
      return true
    end
  end

  def self.subprojects_needs(project)
    response = {}
    if project.selected_addition
      response[:selected_addition] = self.addition_permit_needed?(project)
    end

    if project.selected_acs_struct
      response[:selected_acs_struct] = self.acs_struct_permit_needed?(project)
    end

    if project.selected_deck
      response[:selected_deck] = self.deck_permit_needed?(project)
    end

    if project.selected_pool
      response[:selected_pool] = self.pool_permit_needed?(project)
    end

    if project.selected_cover
      response[:selected_cover] = self.cover_permit_needed?(project)
    end

    if project.selected_window
      response[:selected_window] = self.window_permit_needed?(project)
    end

    if project.selected_door
      response[:selected_door] = self.door_permit_needed?(project)
    end

    if project.selected_wall
      response[:selected_wall] = self.wall_permit_needed?(project)
    end

    if project.selected_siding
      response[:selected_siding] = self.siding_permit_needed?(project)
    end

    if project.selected_floor
      response[:selected_floor] = self.floor_permit_needed?(project)
    end

    # Add more subprojects
    return response
  end

  def self.is_needed?(project)
    if self.addition_permit_needed?(project) ||
        self.acs_struct_permit_needed?(project) ||
        self.deck_permit_needed?(project) ||
        self.pool_permit_needed?(project) ||
        self.cover_permit_needed?(project) ||
        self.window_permit_needed?(project) ||
        self.door_permit_needed?(project) ||
        self.wall_permit_needed?(project) ||
        self.siding_permit_needed?(project) ||
        self.floor_permit_needed?(project) # || self.subproject_permit_needed?(project) (continue to add more subject here)
      return true
    else
      return false
    end
  end
end
