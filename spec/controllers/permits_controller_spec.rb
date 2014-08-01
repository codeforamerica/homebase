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
    #   it "adds a permit" do 
    #     expect{ 
    #       post :create, permit: FactoryGirl.attributes_for(:empty_permit, addition: true) 
    #     }.to change(Permit,:count).by(1)
    #   end

    #   it "redirects to permit_steps_path" do
    #     post :create, permit: FactoryGirl.attributes_for(:empty_permit, addition: true) 
    #     expect(response).to redirect_to(permit_steps_path)
    #   end
    end

    context "when window is selected as true" do
      # it "adds a permit" do 
      #   expect{ 
      #     post :create, permit: FactoryGirl.attributes_for(:empty_permit, window: true) 
      #   }.to change(Permit,:count).by(1)
      # end

      # it "redirects to permit_steps_path" do
      #   post :create, permit: FactoryGirl.attributes_for(:empty_permit, window: true) 
      #   expect(response).to redirect_to(permit_steps_path)
      # end
    end

    context "when door is selected as true" do
      # it "adds a permit" do 
      #   expect{ 
      #     post :create, permit: FactoryGirl.attributes_for(:empty_permit, door: true) 
      #   }.to change(Permit,:count).by(1)
      # end

      # it "redirects to permit_steps_path" do
      #   post :create, permit: FactoryGirl.attributes_for(:empty_permit, door: true) 
      #   expect(response).to redirect_to(permit_steps_path)
      # end
    end

    context "when wall is selected as true" do
      # it "adds a permit" do 
      #   expect{ 
      #     post :create, permit: FactoryGirl.attributes_for(:empty_permit, wall: true) 
      #   }.to change(Permit,:count).by(1)
      # end

      # it "redirects to permit_steps_path" do
      #   post :create, permit: FactoryGirl.attributes_for(:empty_permit, wall: true) 
      #   expect(response).to redirect_to(permit_steps_path)
      # end
    end

    context "when siding is selected as true" do
      # it "adds a permit" do 
      #   expect{ 
      #     post :create, permit: FactoryGirl.attributes_for(:empty_permit, siding: true) 
      #   }.to change(Permit,:count).by(1)
      # end

      # it "redirects to permit_steps_path" do
      #   post :create, permit: FactoryGirl.attributes_for(:empty_permit, siding: true) 
      #   expect(response).to redirect_to(permit_steps_path)
      # end
    end

    context "when floor is selected as true" do
      # it "adds a permit" do 
      #   expect{ 
      #     post :create, permit: FactoryGirl.attributes_for(:empty_permit, floor: true) 
      #   }.to change(Permit,:count).by(1)
      # end

      # it "redirects to permit_steps_path" do
      #   post :create, permit: FactoryGirl.attributes_for(:empty_permit, floor: true) 
      #   expect(response).to redirect_to(permit_steps_path)
      # end
    end

    context "when cover is selected as true" do
      # it "adds a permit" do 
      #   expect{ 
      #     post :create, permit: FactoryGirl.attributes_for(:empty_permit, cover: true) 
      #   }.to change(Permit,:count).by(1)
      # end

      # it "redirects to permit_steps_path" do
      #   post :create, permit: FactoryGirl.attributes_for(:empty_permit, cover: true) 
      #   expect(response).to redirect_to(permit_steps_path)
      # end
    end

    context "when pool is selected as true" do
      # it "adds a permit" do 
      #   expect{ 
      #     post :create, permit: FactoryGirl.attributes_for(:empty_permit, pool: true) 
      #   }.to change(Permit,:count).by(1)
      # end

      # it "redirects to permit_steps_path" do
      #   post :create, permit: FactoryGirl.attributes_for(:empty_permit, pool: true) 
      #   expect(response).to redirect_to(permit_steps_path)
      # end
    end

    context "when deck is selected as true" do
      # it "adds a permit" do 
      #   expect{ 
      #     post :create, permit: FactoryGirl.attributes_for(:empty_permit, deck: true) 
      #   }.to change(Permit,:count).by(1)
      # end

      # it "redirects to permit_steps_path" do
      #   post :create, permit: FactoryGirl.attributes_for(:empty_permit, deck: true) 
      #   expect(response).to redirect_to(permit_steps_path)
      # end
    end

    context "when acs_struct (accessory structure) is selected as true" do
      # it "adds a permit" do 
      #   expect{ 
      #     post :create, permit: FactoryGirl.attributes_for(:empty_permit, deck: true) 
      #   }.to change(Permit,:count).by(1)
      # end

      # it "redirects to permit_steps_path" do
      #   post :create, permit: FactoryGirl.attributes_for(:empty_permit, deck: true) 
      #   expect(response).to redirect_to(permit_steps_path)
      # end
    end

    context "when all improvement projects are selected as false" do       
      it "does not add a permit" do 
        expect{ 
          post :create, permit: FactoryGirl.attributes_for( :empty_permit, 
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
        }.to change(Permit,:count).by(0)
      end

      it "renders permit#new" do
        post :create, permit: FactoryGirl.attributes_for( :empty_permit, 
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

