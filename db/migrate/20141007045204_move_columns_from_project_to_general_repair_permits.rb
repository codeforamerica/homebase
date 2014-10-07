class MoveColumnsFromProjectToGeneralRepairPermits < ActiveRecord::Migration
  def up
    Projects.each do |proj|
      proj.general_repair_permit.addition = proj.addition
      proj.general_repair_permit.house_area = proj.house_area
      proj.general_repair_permit.addition_area = proj.addition_area
      proj.general_repair_permit.ac = proj.ac
      proj.general_repair_permit.window = proj.window
      proj.general_repair_permit.window_count = proj.window_count
      proj.general_repair_permit.door = proj.door
      proj.general_repair_permit.door_count = proj.door_count
      proj.general_repair_permit.wall = proj.wall
      proj.general_repair_permit.siding = proj.siding
      proj.general_repair_permit.floor = proj.floor
      proj.general_repair_permit.cover = proj.cover
      proj.general_repair_permit.pool = proj.pool
      proj.general_repair_permit.deck = proj.deck
      proj.general_repair_permit.acs_struct = proj.acs_struct
      proj.general_repair_permit.accepted_terms = proj.accepted_terms
      proj.general_repair_permit.work_summary = proj.work_summary
      proj.general_repair-permit.project_id = proj.id
      proj.save
    end
  end

  def down
    Projects.each do |proj|
      proj.addition = proj.general_repair_permit.addition
      proj.house_area = proj.general_repair_permit.house_area
      proj.addition_area = proj.general_repair_permit.addition_area
      proj.ac = proj.general_repair_permit.ac
      proj.window = proj.general_repair_permit.window
      proj.window_count = proj.general_repair_permit.window_count
      proj.door = proj.general_repair_permit.door
      proj.door_count = proj.general_repair_permit.door_count
      proj.wall = proj.general_repair_permit.wall
      proj.siding = proj.general_repair_permit.siding
      proj.floor = proj.general_repair_permit.floor
      proj.cover = proj.general_repair_permit.cover
      proj.pool = proj.general_repair_permit.pool
      proj.deck = proj.general_repair_permit.deck
      proj.acs_struct = proj.general_repair_permit.acs_struct
      proj.accepted_terms = proj.general_repair_permit.accepted_terms
      proj.work_summary = proj.general_repair_permit.work_summary
      proj.save
    end
  end

end
