module PermitParams
  def permit_params
   params.require(:permit).permit(
    :owner_name, 
    :owner_address, 
    :addition, 
    :house_area, 
    :addition_area, 
    :ac, 
    :contractor,
    :contractor_name, 
    :contractor_id, 
    :escrow, 
    :license_holder,
    :license_num,
    :agent_name,
    :contact_id,
    :other_contact_id,
    :phone,
    :fax,
    :email,
    :work_summary,
    :job_cost,
    :status
    )
 end
end