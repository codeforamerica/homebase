require 'spec_helper'

describe PermitsController do
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  describe "GET #new" do

    context "when addition is selected as true" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:permit, 
                                                                                      owner_address: nil,
                                                                                      house_area: nil,
                                                                                      addition_area: nil,
                                                                                      ac: nil,
                                                                                      contractor: nil,
                                                                                      contractor_name: nil,
                                                                                      contractor_id: nil,
                                                                                      escrow: nil,
                                                                                      license_holder: nil,
                                                                                      license_num: nil,
                                                                                      agent_name: nil,
                                                                                      contact_id: nil,
                                                                                      other_contact_id: nil,
                                                                                      phone: nil,
                                                                                      fax: nil,
                                                                                      email: nil,
                                                                                      work_summary: nil,
                                                                                      job_cost: nil,
                                                                                      status: nil) }
        

      it { expect(subject).to redirect_to(permit_steps_path) }


      # it { should respond_with 200 }
    end

    context "when addition is selected as false" do
      subject { get :create, :format => 'html', :permit => FactoryGirl.attributes_for(:permit, 
                                                                                      addition: false,
                                                                                      owner_address: nil,
                                                                                      house_area: nil,
                                                                                      addition_area: nil,
                                                                                      ac: nil,
                                                                                      contractor: nil,
                                                                                      contractor_name: nil,
                                                                                      contractor_id: nil,
                                                                                      escrow: nil,
                                                                                      license_holder: nil,
                                                                                      license_num: nil,
                                                                                      agent_name: nil,
                                                                                      contact_id: nil,
                                                                                      other_contact_id: nil,
                                                                                      phone: nil,
                                                                                      fax: nil,
                                                                                      email: nil,
                                                                                      work_summary: nil,
                                                                                      job_cost: nil,
                                                                                      status: nil) }
        

      it { expect(subject).to render_template("new") }


      # it { should respond_with 200 }      
    end

    context "when addition is not selected" do
      subject { get :create, :format=> 'html', :permit => FactoryGirl.attributes_for( :permit,
                                                                                      addition: nil,
                                                                                      owner_address: nil,
                                                                                      house_area: nil,
                                                                                      addition_area: nil,
                                                                                      ac: nil,
                                                                                      contractor: nil,
                                                                                      contractor_name: nil,
                                                                                      contractor_id: nil,
                                                                                      escrow: nil,
                                                                                      license_holder: nil,
                                                                                      license_num: nil,
                                                                                      agent_name: nil,
                                                                                      contact_id: nil,
                                                                                      other_contact_id: nil,
                                                                                      phone: nil,
                                                                                      fax: nil,
                                                                                      email: nil,
                                                                                      work_summary: nil,
                                                                                      job_cost: nil,
                                                                                      status: nil) }

      it { expect(subject).to render_template("new") }
    end
  end

end
