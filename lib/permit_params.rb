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
    :status,
    :window,
    :door,
    :wall,
    :siding,
    :floor,
    :window_count,
    :door_count,
    :cover,
    :pool,
    :deck,
    :acs_struct,
    :accepted_terms,

    # --Virtual Attributes--
    # Room Addition
    :addition_size, :addition_num_story,
    # Accessory Structure
    :acs_struct_size, :acs_struct_num_story,
    # Deck
    :deck_size, :deck_grade, :deck_dwelling_attach, :deck_exit_door,
    # Pool
    :pool_location, :pool_volume,
    # Cover
    :cover_material,
    # Window
    :window_replace_glass,
    # Door
    :door_replace_existing,
    # Wall
    :wall_general_changes,
    # Siding
    :siding_over_existing,
    # Floor
    :floor_covering
    )
 end
end