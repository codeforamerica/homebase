class GeneralRepairPermitPresenter
  attr_reader :project

  def initialize(project)
    @project = project
  end

  def to_hash
    { 
      'DATE'                => Date.today.strftime("%m/%d/%Y"),
      'JOB_COST'            => ActionController::Base.helpers.number_to_currency(project.general_repair_permit.job_cost),
      'OWNER_NAME'          => project.owner_name, 
      'ADDRESS'             => project.owner_address,

      'ADDITIONS_CHECKBOX'  => project.general_repair_permit.addition ? "X" : ' ',
      'SQ_FOOT_HOUSE'       => project.general_repair_permit.house_area,
      'SQ_FOOT_ADDITION'    => project.general_repair_permit.addition_area,
      # @TODO: I may need to put all these choices in shared file
      'AC_NONE'             => project.general_repair_permit.ac == I18n.t('models.project.ac.options.none') ? "X" : ' ',
      'AC_WALL_UNIT'        => project.general_repair_permit.ac == I18n.t('models.project.ac.options.wall') ? "X" : ' ',
      'AC_EXTENDED'         => project.general_repair_permit.ac == I18n.t('models.project.ac.options.extended') ? "X" : ' ',
      'AC_NEW_SPLIT'        => project.general_repair_permit.ac == I18n.t('models.project.ac.options.split') ? "X" : ' ',

      'ACCESSORY_STRUCTURE_CHECKBOX' => project.general_repair_permit.acs_struct ? "X" : ' ',

      'DECK_CHECKBOX'           => project.general_repair_permit.deck ? "X" : ' ',

      'POOL_CHECKBOX'           => project.general_repair_permit.pool ? "X" : ' ',

      'CARPORT_COVER_CHECKBOX'  => project.general_repair_permit.cover ? "X" : ' ',

      'GENERAL_REPAIRS_CHECKBOX'  => (project.general_repair_permit.window ||
                                      project.general_repair_permit.door ||
                                      project.general_repair_permit.wall ||
                                      project.general_repair_permit.siding ||
                                      project.general_repair_permit.floor) ? "X" : ' ',
      'WINDOWS_CHECKBOX'          => project.general_repair_permit.window ? "X" : ' ',
      'NUMBER_WINDOWS'            => project.general_repair_permit.window_count,
      'DOORS_CHECKBOX'            => project.general_repair_permit.door ? "X" : ' ',
      'NUMBER_DOORS'              => project.general_repair_permit.door_count,
      'WALLS_CHECKBOX'            => project.general_repair_permit.wall ? "X" : ' ',
      'SIDING_CHECKBOX'           => project.general_repair_permit.siding ? "X" : ' ',
      'FLOOR_STRUCTURAL_CHECKBOX' => project.general_repair_permit.floor ? "X" : ' ',

      # According to DSD logic, homeowner is contractor if they're doing project
      'CONTRACTOR_NAME'           => project.owner_name,
      'TELEPHONE'                 => project.phone,
      'EMAIL'                     => project.email,
      'WORK_SUMMARY'              => project.general_repair_permit.work_summary,

      'SIGNATURE'                 => "#{project.owner_name}  - SIGNED WITH HOMEBASE #{Date.today.strftime('%m/%d/%Y')}"
    }
  end
end
