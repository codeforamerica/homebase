require 'spec_helper'

describe PermitsController do
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  describe "GET #new" do

    context "when addition is selected as true" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:empty_permit, 
                                                                                      addition: true) }
        

      it { expect(subject).to redirect_to(permit_steps_path) }


      # it { should respond_with 200 }
    end

    context "when window is selected as true" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:empty_permit, 
                                                                                      window: true) }
        

      it { expect(subject).to redirect_to(permit_steps_path) }


      # it { should respond_with 200 }
    end

    context "when door is selected as true" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:empty_permit, 
                                                                                      door: true) }
        

      it { expect(subject).to redirect_to(permit_steps_path) }


      # it { should respond_with 200 }
    end

    context "when wall is selected as true" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:empty_permit, 
                                                                                      wall: true) }
        

      it { expect(subject).to redirect_to(permit_steps_path) }


      # it { should respond_with 200 }
    end

    context "when siding is selected as true" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:empty_permit, 
                                                                                      siding: true) }
        

      it { expect(subject).to redirect_to(permit_steps_path) }


      # it { should respond_with 200 }
    end

    context "when floor is selected as true" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:empty_permit, 
                                                                                      floor: true) }
        

      it { expect(subject).to redirect_to(permit_steps_path) }


      # it { should respond_with 200 }
    end

    context "when cover is selected as true" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:empty_permit, 
                                                                                      cover: true) }
        

      it { expect(subject).to redirect_to(permit_steps_path) }


      # it { should respond_with 200 }
    end

    context "when pool is selected as true" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:empty_permit, 
                                                                                      pool: true) }
        

      it { expect(subject).to redirect_to(permit_steps_path) }


      # it { should respond_with 200 }
    end

    context "when deck is selected as true" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:empty_permit, 
                                                                                      deck: true) }
        

      it { expect(subject).to redirect_to(permit_steps_path) }


      # it { should respond_with 200 }
    end

    context "when acs_struct (accessory structure) is selected as true" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:empty_permit, 
                                                                                      acs_struct: true) }
        

      it { expect(subject).to redirect_to(permit_steps_path) }


      # it { should respond_with 200 }
    end

    context "when all improvement project is selected as false" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:empty_permit, 
                                                                                      addition: false,
                                                                                      window: false,
                                                                                      door: false,
                                                                                      wall: false,
                                                                                      siding: false,
                                                                                      floor: false,
                                                                                      cover: false,
                                                                                      pool: false,
                                                                                      deck: false,
                                                                                      acs_struct: false) }
        

      it { expect(subject).to render_template("new") }


      # it { should respond_with 200 }      
    end

    context "when all improvement project is not selected" do
      subject { get :create, :format=> 'html', :permit => FactoryGirl.attributes_for(:empty_permit) }

      it { expect(subject).to render_template("new") }
    end
  end

end

