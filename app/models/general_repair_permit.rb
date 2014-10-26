class GeneralRepairPermit < ActiveRecord::Base
  belongs_to :project

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
