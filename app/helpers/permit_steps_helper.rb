require 'timeout'
require 'pdf_forms'

module PermitStepsHelper
  def create_permit (file_path, project)
    pdftk = PdfForms.new('pdftk')
    template_path = "#{Rails.root}/lib/PermitForms/general-repairs-form-template.pdf"
    field_names = pdftk.get_field_names("#{Rails.root}/lib/PermitForms/general-repairs-form-template.pdf")

    # PDF Textfields
    #["NCB", "DATE", "ADDRESS", "LOT", "BLOCK", "JOB_COST", "OWNER_NAME", "SQ_FOOT_HOUSE", "SQ_FOOT_ADDITION", 
    # "NUMBER_WINDOWS", "NUMBER_DOORS", "CONTRACTOR_NAME", "CONTRACTOR_ID", "LICENSE_NUMBER", "REGISTERED_LICENSE_HOLDER", 
    # "AUTHORIZED_AGENT_NAME", "CONTACT_ID_NUMBER", "TELEPHONE", "FAX", "WORK_SUMMARY", "EMAIL", "ADDITIONS_CHECKBOX", 
    # "DECK_CHECKBOX", "POOL_CHECKBOX", "CARPORT_COVER_CHECKBOX", "GENERAL_REPAIRS_CHECKBOX", "WINDOWS_CHECKBOX", "DOORS_CHECKBOX", 
    # "WALLS_CHECKBOX", "SIDING_CHECKBOX", "FLOOR_STRUCTURAL_CHECKBOX", "ESCROW_YES_CHECKBOX", "ESCROW_NO_CHECKBOX", 
    # "ACCESSORY_STRUCTURE_CHECKBOX", "AC_NONE", "AC_WALL_UNIT", "AC_EXTENDED", "AC_NEW_SPLIT", "OTHER_CONTACT_ID"]
    
    pdftk.fill_form template_path, 
                    file_path, 
                    { 
                      'DATE'                => Date.today.strftime("%m/%d/%Y"),
                      'JOB_COST'            => view_context.number_to_currency(project.general_repair_permit.job_cost),
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

                    },
                    flatten: true


  
  # Check to make sure file exists before returning, and return status to show whether it is okay to use corresponding link
  # @TODO: Is this neccessary now?
    status = false
    begin
      Timeout::timeout(5) do
        while !(File.exist? file_path) do
          # Not doing anything, just waiting
        end
        status = true
      end
    rescue Timeout::Error
      status = false
    end

    return status

  end

end


