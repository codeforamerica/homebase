# Adding A New Type of Permit or Form

In order to add a new type of permit, you will need to follow the following steps below.  The example below will use a model name Permit as the new type of permit or form:

* app
  * ## Models
    * Project.rb
      * Add Association
        * All permits and forms will belong to project.  Associations are needed to be added to make sure the reference are established.  The following lines will need to be added:

        ```
        has_one :general_repair_permit
        has_one :permit

        accepts_nested_attributes_for :general_repair_permit
        accepts_nested_attributes_for :permit

        ```

      * Create Permit Instance
        * After information has been gathered from user, and he/she would like Homebase to help them apply for permits, the permit will need to be created based on the collected information.

        ```
        def create_needed_permits
          ...

          # Add more permits
          if Permit.is_needed?(self)
            self.permit ||= Permit.new
            attribute = {}

            # This is an example subproject for this permit
            if selected_addition && Permit.addition_permit_needed?(self)
              attributes[:addition] = true
            end
            ...
            # Add more subproject check

            self.permit_attributes = attributes
            is_saved = self.save
          end

          # Add more permits

        end

        # Output: {general_repair_permit => {addition => true, door => true}, permit => {addition => true}}
        def get_require_permits_for_subprojects
          response = {}
          response[:general_repair_permit] = GeneralRepairPermit.subprojects_needs(self)
          response[:permit] = Permit.subprojects_needs(self)

          # Add more forms and permits here
          # response[:name_of_permit] = PermitClass.is_needed?(self)

          return response
        end 

        ```

    * Permit.rb
      A new model for the permit is needed.  You will need to name it accordingly, in this example, it is named Permit.  Permit belongs to project so a project_id will exist in this model.

      ```
      class Permit < ActiveRecord::Base
        belongs_to :project

        ####### Virtual Attributes goes here if any ######
        attr_accessor :confirmed_name

        ####### Validation goes here if any ######

        validates_presence_of :addition_area, :if => :project_active_or_details_addition?

        ...

        def get_project
          Project.find_by_id(project_id)
        end

        def project_active_or_details_addition?
          project_active_or_details? && addition
        end

        ###### Business Logic for when permit is needed ######

        # Return true if this permit is needed, false if not needed, nil if more guidance will be needed from DSD
        def self.addition_permit_needed?(project)
          if project.addition_size.eql?("lessThan1000") && project.addition_num_story.eql?("1Story")
            return true
          else
            return nil
          end
        end

        ....

        def self.subprojects_needs(project)
          response = {}
          if project.selected_addition
            response[:selected_addition] = self.addition_permit_needed?(project)
          end
          # Add more subprojects
          return response
        end

        def self.is_needed?(project)
          if self.addition_permit_needed?(project) # || Add other subproject check here
              return true
          else
            return false
          end
        end
      end

      ```
  * ## Lib
    * PermitForms
      * Place your permit template PDF file here.

    * project_params.rb
      * This file will give Project permission to access the Permit's attributes

      ```
      module ProjectParams
        def project_params
          params.require(:project).permit(
          ...
          permit_attributes:  [ :id,
                                : addition,
                                ...
                              ]
          )
        end
      end

      ```
    * permit_presenter.rb
      * This new file will create the necessary hash for filling out the template permit form

      ```
      class PermitPresenter
        attr_reader :project

        def initialize(project)
          @project = project
        end

        def to_hash
          {
            'DATE'    => Date.today.strftime("%m/%d/%Y"),
            'ADDITIONS_CHECKBOX'  => project.permit.addition ? "X" : ' ',
            ...
          }
        end
      end

      ```

    * project_permit_creator.rb
      * Permit will need to be added here to generate the actual permit form.
      * @TODO: This file needs to be refactored to support multiple permits.

      ```
      class ProjectPermitCreator
        ...

        def create_permit

          ...

          if project.permit
            permit_template_path = "#{Rails.root}/lib/PermitForms/permit-form-template.pdf"

            # PDF Textfields
            form
          end
        end
      end

      ```
  * ## Views
    * permit_mailer
      * send_permit_application.html.erb
        If there's any specific information that needs to be displayed for the Permit, this will need to be updated.

    * project_steps
      * confirm_terms.html.erb
        If there's any specific terms that user needs to agree too, this will need to be updated.  You may want to think about whether some of the current term attributes that belong to general repair permit should be moved to another model, such as project or other new model.

      * display_permits.html.erb
        Information on the new Permit will need to be included here.

      * display_summary.html.erb
        If there's any specific attributes from the new Permit that needs to be displayed, this will need to be updated.

      * enter_details.html.erb
        If there's attributes from the new Permit that needs to be filled out, this will need to be updated.

  * ## Controllers
    * project_steps_controller.rb
      There may be needs to add specific variables from the new Permit.  This will need to go here.

* ##db
  * migrate
    * Create a migration to create Permit.  You can run a similar command in your terminal below.

    ```
    rails generate migration CreatePermits addition:boolean

    ```

    This will create a migration file with a timestamp at the beginning of the filename, and it will look like the following:

    ```
    class CreatePermits < ActiveRecord::Migration
      def change
        create_table :permits do |t|
          t.boolean :addition

          t.timestamps
        end
      end
    end

    ```

    You can also edit the file to include more attributes if needed before running the db:migrate command.

    * Add Project reference to Permit.  You can run a similar command in your terminal below.

    ```
    rails generate migration AddProjectRefToPermits

    ```

    This will create a migration file, and you will need to add the following lines to the `change` method:

    ```
    class AddProjectRefToPermits < ActiveRecord::Migration
      def change
        add_reference :permits, :project, index: true
      end
    end

    ```

    After these files are created, you can run `db:migrate` in your terminal to create the table and reference in the database:

    ```
    bundle exec rake db:migrate

    ```

* Spec
  * Tests will need to be updated if new type of permit has been added.


