require 'timeout'
require 'pdf_forms'

module PermitStepsHelper
  def create_permit (file_path, permit)
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
                      'JOB_COST'            => view_context.number_to_currency(permit.job_cost),
                      'OWNER_NAME'          => permit.owner_name, 
                      'ADDRESS'             => permit.owner_address,

                      'ADDITIONS_CHECKBOX'  => permit.addition ? "X" : ' ',
                      'SQ_FOOT_HOUSE'       => permit.house_area,
                      'SQ_FOOT_ADDITION'    => permit.addition_area,
                      # @TODO: I may need to put all these choices in shared file
                      'AC_NONE'             => permit.ac == I18n.t('ac.options.none') ? "X" : ' ',
                      'AC_WALL_UNIT'        => permit.ac == I18n.t('ac.options.wall') ? "X" : ' ',
                      'AC_EXTENDED'         => permit.ac == I18n.t('ac.options.extended') ? "X" : ' ',
                      'AC_NEW_SPLIT'        => permit.ac == I18n.t('ac.options.split') ? "X" : ' ',

                      'ACCESSORY_STRUCTURE_CHECKBOX' => permit.acs_struct ? "X" : ' ',

                      'DECK_CHECKBOX'           => permit.deck ? "X" : ' ',

                      'POOL_CHECKBOX'           => permit.pool ? "X" : ' ',
                      
                      'CARPORT_COVER_CHECKBOX'  => permit.cover ? "X" : ' ',

                      'GENERAL_REPAIRS_CHECKBOX'  => (permit.window ||
                                                      permit.door ||
                                                      permit.wall ||
                                                      permit.siding ||
                                                      permit.floor) ? "X" : ' ',
                      'WINDOWS_CHECKBOX'          => permit.window ? "X" : ' ',
                      'NUMBER_WINDOWS'            => permit.window_count,
                      'DOORS_CHECKBOX'            => permit.door ? "X" : ' ',
                      'NUMBER_DOORS'              => permit.door_count,
                      'WALLS_CHECKBOX'            => permit.wall ? "X" : ' ',
                      'SIDING_CHECKBOX'           => permit.siding ? "X" : ' ',
                      'FLOOR_STRUCTURAL_CHECKBOX' => permit.floor ? "X" : ' ',

                      # According to DSD logic, homeowner is contractor if they're doing project
                      'CONTRACTOR_NAME'           => permit.owner_name,
                      'TELEPHONE'                 => permit.phone,
                      'EMAIL'                     => permit.email,
                      'WORK_SUMMARY'              => permit.work_summary,

                      'SIGNATURE'                 => "#{permit.owner_name}  - SIGNED WITH HOMEBASE #{Date.today.strftime('%m/%d/%Y')}"

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


