require 'spec_helper'

describe PermitsController do
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  describe "GET #new" do
    it "initalizes a permit" do
      get :new
      expect(assigns(:permit)).to be_a_new(Permit)
    end
  end
  describe "POST #create" do
    context "when addition is selected as true" do
      it "adds a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_addition: "1") 
        }.to change(Permit,:count).by(1)
      end

      it "redirects to permit_steps_path" do
        post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_addition: "1") 
        expect(response).to redirect_to(permit_steps_path)
      end
    end

    context "when window is selected as true" do
      it "adds a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_window: "1") 
        }.to change(Permit,:count).by(1)
      end

      it "redirects to permit_steps_path" do
        post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_window: "1") 
        expect(response).to redirect_to(permit_steps_path)
      end
    end

    context "when door is selected as true" do
      it "adds a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_door: "1") 
        }.to change(Permit,:count).by(1)
      end

      it "redirects to permit_steps_path" do
        post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_door: "1") 
        expect(response).to redirect_to(permit_steps_path)
      end
    end

    context "when wall is selected as true" do
      it "adds a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_wall: "1") 
        }.to change(Permit,:count).by(1)
      end

      it "redirects to permit_steps_path" do
        post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_wall: "1") 
        expect(response).to redirect_to(permit_steps_path)
      end
    end

    context "when siding is selected as true" do
      it "adds a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_siding: "1") 
        }.to change(Permit,:count).by(1)
      end

      it "redirects to permit_steps_path" do
        post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_siding: "1") 
        expect(response).to redirect_to(permit_steps_path)
      end
    end

    context "when floor is selected as true" do
      it "adds a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_floor: "1") 
        }.to change(Permit,:count).by(1)
      end

      it "redirects to permit_steps_path" do
        post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_floor: "1") 
        expect(response).to redirect_to(permit_steps_path)
      end
    end

    context "when cover is selected as true" do
      it "adds a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_cover: "1") 
        }.to change(Permit,:count).by(1)
      end

      it "redirects to permit_steps_path" do
        post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_cover: "1") 
        expect(response).to redirect_to(permit_steps_path)
      end
    end

    context "when pool is selected as true" do
      it "adds a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_pool: "1") 
        }.to change(Permit,:count).by(1)
      end

      it "redirects to permit_steps_path" do
        post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_pool: "1") 
        expect(response).to redirect_to(permit_steps_path)
      end
    end

    context "when deck is selected as true" do
      it "adds a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_deck: "1") 
        }.to change(Permit,:count).by(1)
      end

      it "redirects to permit_steps_path" do
        post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_deck: "1") 
        expect(response).to redirect_to(permit_steps_path)
      end
    end

    context "when acs_struct (accessory structure) is selected as true" do
      it "adds a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_deck: "1") 
        }.to change(Permit,:count).by(1)
      end

      it "redirects to permit_steps_path" do
        post :create, permit: FactoryGirl.attributes_for(:empty_permit, selected_deck: "1") 
        expect(response).to redirect_to(permit_steps_path)
      end
    end

    context "when all improvement projects are selected as false" do       
      it "does not add a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for( :empty_permit, 
                                                            selected_addition: "0",
                                                            selected_window: "0",
                                                            selected_door: "0",
                                                            selected_wall: "0",
                                                            selected_siding: "0",
                                                            selected_floor: "0",
                                                            selected_cover: "0",
                                                            selected_pool: "0",
                                                            selected_deck: "0",
                                                            selected_acs_struct: "0",
                                                            status: nil) 
        }.to change(Permit,:count).by(0)
      end

      it "renders permit#new" do
        post :create, permit: FactoryGirl.attributes_for( :empty_permit, 
                                                          selected_addition: "0",
                                                          selected_window: "0",
                                                          selected_door: "0",
                                                          selected_wall: "0",
                                                          selected_siding: "0",
                                                          selected_floor: "0",
                                                          selected_cover: "0",
                                                          selected_pool: "0",
                                                          selected_deck: "0",
                                                          selected_acs_struct: "0",
                                                          status: nil) 
        expect(response).to render_template("new")
      end
    
    end

    context "when all improvement projects are not selected" do
      it "does not add a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for(:empty_permit) 
        }.to change(Permit,:count).by(0)
      end

      it "renders permit#new" do
        post :create, permit: FactoryGirl.attributes_for(:empty_permit) 
        expect(response).to render_template("new")
      end
    end
  end

end

