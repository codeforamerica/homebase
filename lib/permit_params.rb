module PermitParams
  def permit_params
   params.require(:permit).permit(
    :owner_name, 
    :owner_address, 
    :addition, 
    :house_area, 
    :addition_area, 
    :ac, 
    :phone,
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
    :selected_addition,
    :selected_acs_struct,
    :selected_deck,
    :selected_pool,
    :selected_cover,
    :selected_window,
    :selected_door,
    :selected_wall,
    :selected_siding,
    :selected_floor,

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
    :floor_covering,

    :confirmed_name,
    :contractor
    )
 end
end