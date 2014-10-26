class AddVirtualAttributesToProjects < ActiveRecord::Migration
  def change
    # User selected projects
    add_column :projects, :selected_addition, :boolean
    add_column :projects, :selected_acs_struct, :boolean
    add_column :projects, :selected_deck, :boolean
    add_column :projects, :selected_pool, :boolean
    add_column :projects, :selected_cover, :boolean
    add_column :projects, :selected_window, :boolean
    add_column :projects, :selected_door, :boolean
    add_column :projects, :selected_wall, :boolean
    add_column :projects, :selected_siding, :boolean
    add_column :projects, :selected_floor, :boolean
    # Room Addition
    add_column :projects, :addition_size, :string
    add_column :projects,  :addition_num_story, :string
    # Accessory Structure
    add_column :projects, :acs_struct_size, :string
    add_column :projects, :acs_struct_num_story, :string
    # Deck
    add_column :projects, :deck_size, :string
    add_column :projects, :deck_grade, :string
    add_column :projects, :deck_dwelling_attach, :string
    add_column :projects, :deck_exit_door, :string
    # Pool
    add_column :projects, :pool_location, :string
    add_column :projects, :pool_volume, :string
    # Window
    add_column :projects, :window_replace_glass, :boolean
    # Door
    add_column :projects, :door_replace_existing, :boolean
    # Wall
    add_column :projects, :wall_general_changes, :boolean
    # Siding
    add_column :projects, :siding_over_existing, :boolean
    # Floor
    add_column :projects, :floor_covering, :boolean

  end
end
