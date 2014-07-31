require 'spec_helper'

describe Permit do
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  context "with valid attributes" do

#    it { expect(FactoryGirl.create(:permit)).to be_valid }

#    it { expect(FactoryGirl.build(:permit, owner_address: nil, status: nil)).to be_valid }

#    it { expect(FactoryGirl.build(:permit, house_area: nil, status: nil)).to be_valid }
    # it { expect(FactoryGirl.build(:permit, house_area: nil, status: "answer_screener")).to be_valid }
    it { expect(FactoryGirl.build(:permit, house_area: nil, status: "display_permits")).to be_valid }
    # it { expect(FactoryGirl.build(:permit, house_area: "a", status: "answer_screener")).to be_valid }
    it { expect(FactoryGirl.build(:permit, house_area: "a", status: "display_permits")).to be_valid }

    # it { expect(FactoryGirl.build(:permit, addition_area: nil, status: "answer_screener")).to be_valid }
    it { expect(FactoryGirl.build(:permit, addition_area: nil, status: "display_permits")).to be_valid }
    # it { expect(FactoryGirl.build(:permit, addition_area: "a", status: "answer_screener")).to be_valid }
    it { expect(FactoryGirl.build(:permit, addition_area: "a", status: "display_permits")).to be_valid }
    # it { expect(FactoryGirl.build(:permit, addition_area: 1000, status: "answer_screener")).to be_valid }
    it { expect(FactoryGirl.build(:permit, addition_area: 1000, status: "display_permits")).to be_valid }

    # it { expect(FactoryGirl.build(:permit, ac: nil, status: "answer_screener")).to be_valid }
    it { expect(FactoryGirl.build(:permit, ac: nil, status: "display_permits")).to be_valid }

    # it { expect(FactoryGirl.build(:permit, contractor: nil, status: "enter_address")).to be_valid }
    # it { expect(FactoryGirl.build(:permit, contractor: nil, status: "display_permits")).to be_valid }

    # it { expect(FactoryGirl.build(:permit, work_summary: nil, status: "answer_screener")).to be_valid }
    it { expect(FactoryGirl.build(:permit, work_summary: nil, status: "display_permits")).to be_valid }

    # it { expect(FactoryGirl.build(:permit, job_cost: nil, status: "answer_screener")).to be_valid }
    it { expect(FactoryGirl.build(:permit, job_cost: nil, status: "display_permits")).to be_valid }

  end

  context "with invalid attributes" do

    before { @ipermit = FactoryGirl.build(:permit, owner_name: nil) }
    # it "adds the correct error message" do
    #   @ipermit.valid?
    #   expect(@ipermit).to be_invalid
    #   expect(@ipermit.errors.count).to eq(1)
    #   expect(@ipermit.errors).to have_key(:owner_name)
    #   expect(@ipermit.errors.messages[:owner_name]).to include("Please enter home owner name.")
    # end

    it { expect(FactoryGirl.build(:permit, owner_name: nil)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, owner_name: nil, status: "enter_details")).to be_invalid }

    it { expect(FactoryGirl.build(:permit, owner_address: nil)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, owner_address: nil, status: "answer_screener")).to be_invalid }
    it { expect(FactoryGirl.build(:permit, owner_address: "155 9th St, San Francisco, CA 94103")).to be_invalid }
    it { expect(FactoryGirl.build(:permit, owner_address: "155 9th St, San Francisco, CA 94103", status: "answer_screener")).to be_invalid }

    it { expect(FactoryGirl.build(:permit,  addition: false, 
                                            window: false, 
                                            door: false, 
                                            wall: false, 
                                            siding: false, 
                                            floor: false,
                                            cover: false,
                                            pool: false,
                                            deck: false,
                                            acs_struct: false,
                                            status: nil)).to be_invalid }

    it { expect(FactoryGirl.build(:permit,  addition: nil,
                                            window: nil,
                                            door: nil,
                                            wall: nil,
                                            siding: nil,
                                            floor: nil,
                                            cover: nil,
                                            pool: nil,
                                            deck: nil,
                                            acs_struct: nil,
                                            status: nil)).to be_invalid }

    it { expect(FactoryGirl.build(:permit, house_area: nil)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, house_area: nil, status: "enter_details")).to be_invalid }
    it { expect(FactoryGirl.build(:permit, house_area: "a")).to be_invalid }
    it { expect(FactoryGirl.build(:permit, house_area: "a", status: "enter_details")).to be_invalid }

    it { expect(FactoryGirl.build(:permit, addition_area: nil)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, addition_area: nil, status: "enter_details")).to be_invalid }
    it { expect(FactoryGirl.build(:permit, addition_area: "a")).to be_invalid }
    it { expect(FactoryGirl.build(:permit, addition_area: "a", status: "enter_details")).to be_invalid }
    it { expect(FactoryGirl.build(:permit, addition_area: 1000)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, addition_area: 1000, status: "enter_details")).to be_invalid }

    it { expect(FactoryGirl.build(:permit, ac: nil)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, ac: nil, status: "enter_details")).to be_invalid }

    # it { expect(FactoryGirl.build(:permit, contractor: nil)).to be_invalid }
    # it { expect(FactoryGirl.build(:permit, contractor: nil, status: "enter_details")).to be_invalid }

    it { expect(FactoryGirl.build(:permit, work_summary: nil)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, work_summary: nil, status: "enter_details")).to be_invalid }

    it { expect(FactoryGirl.build(:permit, job_cost: nil)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, job_cost: nil, status: "enter_details")).to be_invalid }
  end

  after(:all) do
    @cosa.destroy
  end
end
