class MoveColumnsFromProjectToGeneralRepairPermits < ActiveRecord::Migration
  def up
    execute "INSERT INTO general_repair_permits (addition, house_area, addition_area, ac, \"window\", window_count, door, door_count, wall, siding, floor, cover, pool, deck, acs_struct, accepted_terms, work_summary, job_cost, project_id) SELECT addition, house_area, addition_area, ac, \"window\", window_count, door, door_count, wall, siding, floor, cover, pool, deck, acs_struct, accepted_terms, work_summary, job_cost, id FROM projects"
  end

  def down
    execute "UPDATE projects SET addition = g.addition FROM (SELECT project_id, addition FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET house_area = g.house_area FROM (SELECT project_id, house_area FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET addition_area = g.addition_area FROM (SELECT project_id, addition_area FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET ac = g.ac FROM (SELECT project_id, ac FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET \"window\" = g.window FROM (SELECT project_id, \"window\" FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET window_count = g.window_count FROM (SELECT project_id, window_count FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET door = g.door FROM (SELECT project_id, door FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET door_count = g.door_count FROM (SELECT project_id, door_count FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET wall = g.wall FROM (SELECT project_id, wall FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET siding = g.siding FROM (SELECT project_id, siding FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET floor = g.floor FROM (SELECT project_id, floor FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET cover = g.cover FROM (SELECT project_id, cover FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET pool = g.pool FROM (SELECT project_id, pool FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET deck = g.deck FROM (SELECT project_id, deck FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET acs_struct = g.acs_struct FROM (SELECT project_id, acs_struct FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET accepted_terms = g.accepted_terms FROM (SELECT project_id, accepted_terms FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET work_summary = g.work_summary FROM (SELECT project_id, work_summary FROM general_repair_permits) AS g WHERE g.project_id = id"
    execute "UPDATE projects SET job_cost = g.job_cost FROM (SELECT project_id, job_cost FROM general_repair_permits) AS g WHERE g.project_id = id"
  end

end
