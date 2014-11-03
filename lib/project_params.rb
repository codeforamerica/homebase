module ProjectParams
  def project_params
   params.require(:project).permit(
    :id,
    :owner_name, 
    :owner_address, 
    :lat,
    :lng,
    :phone,
    :email,
    :status,
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

    :contractor,
    general_repair_permit_attributes: [ :id,
                                        :addition,
                                        :house_area,
                                        :addition_area,
                                        :ac,
                                        :window_count,
                                        :door,
                                        :door_count,
                                        :wall,
                                        :siding,
                                        :floor,
                                        :cover,
                                        :pool,
                                        :deck,
                                        :acs_struct,
                                        :accepted_terms,
                                        :work_summary,
                                        :job_cost,
                                        :project_id,
                                        :confirmed_name]
    )
 end
end