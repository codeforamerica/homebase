require 'timeout'
require 'pdf_forms'
require 'general_repair_permit_presenter'

class ProjectPermitCreator
  attr_reader :file_path, :project, :pdftk

  def initialize(file_path, project, pdftk = PdfForms.new('pdftk'))
    @file_path = file_path
    @project = project
    @pdftk = pdftk
  end  

  def create_permit
    if project.general_repair_permit
      template_path = "#{Rails.root}/lib/PermitForms/general-repairs-form-template.pdf"

      # PDF Textfields
      #["NCB", "DATE", "ADDRESS", "LOT", "BLOCK", "JOB_COST", "OWNER_NAME", "SQ_FOOT_HOUSE", "SQ_FOOT_ADDITION", 
      # "NUMBER_WINDOWS", "NUMBER_DOORS", "CONTRACTOR_NAME", "CONTRACTOR_ID", "LICENSE_NUMBER", "REGISTERED_LICENSE_HOLDER", 
      # "AUTHORIZED_AGENT_NAME", "CONTACT_ID_NUMBER", "TELEPHONE", "FAX", "WORK_SUMMARY", "EMAIL", "ADDITIONS_CHECKBOX", 
      # "DECK_CHECKBOX", "POOL_CHECKBOX", "CARPORT_COVER_CHECKBOX", "GENERAL_REPAIRS_CHECKBOX", "WINDOWS_CHECKBOX", "DOORS_CHECKBOX", 
      # "WALLS_CHECKBOX", "SIDING_CHECKBOX", "FLOOR_STRUCTURAL_CHECKBOX", "ESCROW_YES_CHECKBOX", "ESCROW_NO_CHECKBOX", 
      # "ACCESSORY_STRUCTURE_CHECKBOX", "AC_NONE", "AC_WALL_UNIT", "AC_EXTENDED", "AC_NEW_SPLIT", "OTHER_CONTACT_ID"]
      
      form_data = GeneralRepairPermitPresenter.new(project).to_hash

      pdftk.fill_form template_path, 
                      file_path, 
                      form_data,
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
end