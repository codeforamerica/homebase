require 'timeout'
require 'pdf_forms'

module PermitStepsHelper
	def create_permit (file_path)
		pdftk = PdfForms.new('pdftk')
		template_path = "#{Rails.root}/lib/PermitForms/general-repairs-form-template.pdf"
		field_names = pdftk.get_field_names("#{Rails.root}/lib/PermitForms/general-repairs-form-template.pdf")

		pdftk.fill_form template_path, 
		                file_path, 
		                { 
		                  'DATE'                => Date.today.strftime("%m/%d/%Y"),
		                  'JOB_COST'            => "$ #{@permit.job_cost}",
		                  'OWNER_NAME'          => @permit.owner_name, 
		                  'ADDRESS'             => @permit.owner_address,

		                  'ADDITIONS_CHECKBOX'  => @permit.addition ? "X" : ' ',
		                  'SQ_FOOT_HOUSE'       => @permit.house_area,
		                  'SQ_FOOT_ADDITION'    => @permit.addition_area,
		                  'AC_NONE'             => @permit.ac == "None" ? "X" : ' ',
		                  'AC_WALL_UNIT'        => @permit.ac == "Wall Unit" ? "X" : ' ',
		                  'AC_EXTENDED'         => @permit.ac == "Extended from Main House" ? "X" : ' ',
		                  'AC_NEW_SPLIT'        => @permit.ac == "New Split System" ? "X" : ' ',

		                  'ACCESSORY_STRUCTURE_CHECKBOX' => @permit.acs_struct ? "X" : ' ',

		                  'DECK_CHECKBOX'           => @permit.deck ? "X" : ' ',

		                  'POOL_CHECKBOX'           => @permit.pool ? "X" : ' ',
		                  
		                  'CARPORT_COVER_CHECKBOX'  => @permit.cover ? "X" : ' ',

		                  'GENERAL_REPAIRS_CHECKBOX'  => (@permit.window ||
		                                                  @permit.door ||
		                                                  @permit.wall ||
		                                                  @permit.siding ||
		                                                  @permit.floor) ? "X" : ' ',
		                  'WINDOWS_CHECKBOX'          => @permit.window ? "X" : ' ',
		                  'NUMBER_WINDOWS'            => @permit.window_count,
		                  'DOORS_CHECKBOX'            => @permit.door ? "X" : ' ',
		                  'NUMBER_DOORS'              => @permit.door_count,
		                  'WALLS_CHECKBOX'            => @permit.wall ? "X" : ' ',
		                  'SIDING_CHECKBOX'           => @permit.siding ? "X" : ' ',
		                  'FLOOR_STRUCTURAL_CHECKBOX' => @permit.floor ? "X" : ' ',

		                  'CONTRACTOR_NAME'           => @permit.contractor_name,
		                  'CONTRACTOR_ID'             => @permit.contractor_id,
		                  'ESCROW_YES_CHECKBOX'       => @permit.escrow ? "X" : ' ',
		                  'ESCROW_NO_CHECKBOX'        => (!@permit.escrow && @permit.escrow != nil) ? "X" : ' ',
		                  'REGISTERED_LICENSE_HOLDER' => @permit.license_holder,
		                  'LICENSE_NUMBER'            => @permit.license_num,
		                  'AUTHORIZED_AGENT_NAME'     => @permit.agent_name,
		                  'CONTACT_ID_NUMBER'         => @permit.contact_id,
		                  'PHONE'                     => @permit.phone,
		                  'EMAIL'                     => @permit.email,
		                  'OTHER_CONTACT_ID'          => @permit.other_contact_id,
		                  'WORK_SUMMARY'              => @permit.work_summary

		                },
		                flatten: true

		#["NCB", "DATE", "ADDRESS", "LOT", "BLOCK", "JOB_COST", "OWNER_NAME", "SQ_FOOT_HOUSE", "SQ_FOOT_ADDITION", 
		# "NUMBER_WINDOWS", "NUMBER_DOORS", "CONTRACTOR_NAME", "CONTRACTOR_ID", "LICENSE_NUMBER", "REGISTERED_LICENSE_HOLDER", 
		# "AUTHORIZED_AGENT_NAME", "CONTACT_ID_NUMBER", "TELEPHONE", "FAX", "WORK_SUMMARY", "EMAIL", "ADDITIONS_CHECKBOX", 
		# "DECK_CHECKBOX", "POOL_CHECKBOX", "CARPORT_COVER_CHECKBOX", "GENERAL_REPAIRS_CHECKBOX", "WINDOWS_CHECKBOX", "DOORS_CHECKBOX", 
		# "WALLS_CHECKBOX", "SIDING_CHECKBOX", "FLOOR_STRUCTURAL_CHECKBOX", "ESCROW_YES_CHECKBOX", "ESCROW_NO_CHECKBOX", 
		# "ACCESSORY_STRUCTURE_CHECKBOX", "AC_NONE", "AC_WALL_UNIT", "AC_EXTENDED", "AC_NEW_SPLIT", "OTHER_CONTACT_ID"]

	
	# Check to make sure file exists before returning, and return status to show whether it is okay to use corresponding link
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


