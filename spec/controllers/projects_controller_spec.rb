require 'spec_helper'

describe ProjectsController do
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  describe "GET #new" do
    it "initalizes a project" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end
  end
  describe "POST #create" do
    context "when addition is selected as true" do
    #   it "adds a project" do 
    #     expect{ 
    #       post :create, project: FactoryGirl.attributes_for(:empty_project, addition: true) 
    #     }.to change(Project,:count).by(1)
    #   end

    #   it "redirects to project_steps_path" do
    #     post :create, project: FactoryGirl.attributes_for(:empty_project, addition: true) 
    #     expect(response).to redirect_to(project_steps_path)
    #   end
    end

    context "when window is selected as true" do
      # it "adds a project" do 
      #   expect{ 
      #     post :create, project: FactoryGirl.attributes_for(:empty_project, window: true) 
      #   }.to change(Project,:count).by(1)
      # end

      # it "redirects to project_steps_path" do
      #   post :create, project: FactoryGirl.attributes_for(:empty_project, window: true) 
      #   expect(response).to redirect_to(project_steps_path)
      # end
    end

    context "when door is selected as true" do
      # it "adds a project" do 
      #   expect{ 
      #     post :create, project: FactoryGirl.attributes_for(:empty_project, door: true) 
      #   }.to change(Project,:count).by(1)
      # end

      # it "redirects to project_steps_path" do
      #   post :create, project: FactoryGirl.attributes_for(:empty_project, door: true) 
      #   expect(response).to redirect_to(project_steps_path)
      # end
    end

    context "when wall is selected as true" do
      # it "adds a project" do 
      #   expect{ 
      #     post :create, project: FactoryGirl.attributes_for(:empty_project, wall: true) 
      #   }.to change(Project,:count).by(1)
      # end

      # it "redirects to project_steps_path" do
      #   post :create, project: FactoryGirl.attributes_for(:empty_project, wall: true) 
      #   expect(response).to redirect_to(permitt_steps_path)
      # end
    end

    context "when siding is selected as true" do
      # it "adds a project" do 
      #   expect{ 
      #     post :create, project: FactoryGirl.attributes_for(:empty_project, siding: true) 
      #   }.to change(Project,:count).by(1)
      # end

      # it "redirects to project_steps_path" do
      #   post :create, project: FactoryGirl.attributes_for(:empty_project, siding: true) 
      #   expect(response).to redirect_to(project_steps_path)
      # end
    end

    context "when floor is selected as true" do
      # it "adds a project" do 
      #   expect{ 
      #     post :create, project: FactoryGirl.attributes_for(:empty_project, floor: true) 
      #   }.to change(Project,:count).by(1)
      # end

      # it "redirects to project_steps_path" do
      #   post :create, project: FactoryGirl.attributes_for(:empty_project, floor: true) 
      #   expect(response).to redirect_to(project_steps_path)
      # end
    end

    context "when cover is selected as true" do
      # it "adds a project" do 
      #   expect{ 
      #     post :create, project: FactoryGirl.attributes_for(:empty_project, cover: true) 
      #   }.to change(Project,:count).by(1)
      # end

      # it "redirects to project_steps_path" do
      #   post :create, project: FactoryGirl.attributes_for(:empty_project, cover: true) 
      #   expect(response).to redirect_to(project_steps_path)
      # end
    end

    context "when pool is selected as true" do
      # it "adds a project" do 
      #   expect{ 
      #     post :create, project: FactoryGirl.attributes_for(:empty_project, pool: true) 
      #   }.to change(Project,:count).by(1)
      # end

      # it "redirects to project_steps_path" do
      #   post :create, project: FactoryGirl.attributes_for(:empty_project, pool: true) 
      #   expect(response).to redirect_to(project_steps_path)
      # end
    end

    context "when deck is selected as true" do
      # it "adds a project" do 
      #   expect{ 
      #     post :create, project: FactoryGirl.attributes_for(:empty_project, deck: true) 
      #   }.to change(Project,:count).by(1)
      # end

      # it "redirects to project_steps_path" do
      #   post :create, project: FactoryGirl.attributes_for(:empty_project, deck: true) 
      #   expect(response).to redirect_to(project_steps_path)
      # end
    end

    context "when acs_struct (accessory structure) is selected as true" do
      # it "adds a project" do 
      #   expect{ 
      #     post :create, project: FactoryGirl.attributes_for(:empty_project, deck: true) 
      #   }.to change(Project,:count).by(1)
      # end

      # it "redirects to project_steps_path" do
      #   post :create, project: FactoryGirl.attributes_for(:empty_project, deck: true) 
      #   expect(response).to redirect_to(project_steps_path)
      # end
    end

    context "when all improvement projects are selected as false" do       
      it "does not add a project" do 
        expect{ 
          post :create, project: FactoryGirl.attributes_for( :empty_project, 
                                                            addition: false,
                                                            window: false,
                                                            door: false,
                                                            wall: false,
                                                            siding: false,
                                                            floor: false,
                                                            cover: false,
                                                            pool: false,
                                                            deck: false,
                                                            acs_struct: false) 
        }.to change(Project,:count).by(0)
      end

      it "renders project#new" do
        post :create, project: FactoryGirl.attributes_for( :empty_project, 
                                                          addition: false,
                                                          window: false,
                                                          door: false,
                                                          wall: false,
                                                          siding: false,
                                                          floor: false,
                                                          cover: false,
                                                          pool: false,
                                                          deck: false,
                                                          acs_struct: false) 
        expect(response).to render_template("new")
      end
    
    end

    context "when all improvement projects are not selected" do
      it "does not add a project" do 
        expect{ 
          post :create, project: FactoryGirl.attributes_for(:empty_project) 
        }.to change(Project,:count).by(0)
      end

      it "renders project#new" do
        post :create, project: FactoryGirl.attributes_for(:empty_project) 
        expect(response).to render_template("new")
      end
    end
  end

end

