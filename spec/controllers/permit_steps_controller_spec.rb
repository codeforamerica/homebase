require 'spec_helper'

describe PermitStepsController do
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  describe "GET #show" do
    context "when step is answer_screener" do
    end

    context "when step is display_permit" do
    end

    context "when step is enter_details" do
    end

    context "when step is display_summary" do
      it "add a generated pdf" do
        permit1 = Permit.create(FactoryGirl.attributes_for(:permit))
        session[:permit_id] = permit1.id
        
        expect {
          get :show, id: :display_summary, permit: FactoryGirl.attributes_for(:permit)
        }.to change(Binary,:count).by(1)
        expect {
          get :show, id: :display_summary, permit: FactoryGirl.attributes_for(:permit)
        }.to change(PermitBinaryDetail,:count).by(1)        
      end
    end
  end

  describe "GET #update" do
    context "when step is enter_address" do
    end

    context "when step is display_permit" do
    end

    context "when step is enter_details" do 
      # before(:each) do
      #   permit1 = Permit.create(FactoryGirl.attributes_for(:permit, owner_address: "302 Madison St"))
      #   session[:permit_id] = permit1.id

      #   put :update, id: :enter_details, permit: permit1
      #   permit1.reload
      # end

      # it "checks and changes the owner address to a full complete address" do
      #   expect{ permit1.owner_address }.to eq("302 Madison Street, San Antonio, TX 78204, USA")
      # end
      # expect {
      #   put :update, id: :enter_details, permit: FactoryGirl.attributes_for(:permit, owner_address: "302 Madison St")
      # }
      # before(:each) do
      #   permit1 = 
      #   put :update, { :id => 'enter_details', permit: Permit.create(FactoryGirl.attributes_for(:permit))}
      #   @attr = { :title => "new title", :content => "new content" }
      #   put :update, :id => @article.id, :article => @attr
      #   @article.reload
      # end

      # it { @article.title.should eql @attr[:title] }
      # it { @article.content.should eql @attr[:content] }
    end

    context "when step is display_summary" do
    end
  end


# # Test find_friends block of show action
# get :show, id: :find_friends

# # Test find_friends block of update action
# put :update, {'id' => 'find_friends', "user" => { "id" => @user.id.to_s }}


end
