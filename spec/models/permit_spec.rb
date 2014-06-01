require 'spec_helper'

describe Permit do
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  context "with valid attributes" do

    it { expect(FactoryGirl.create(:permit)).to be_valid }

    it { expect(FactoryGirl.build(:permit, owner_address: nil, status: nil)).to be_valid }

    it { expect(FactoryGirl.build(:permit, house_area: nil, status: nil)).to be_valid }
    it { expect(FactoryGirl.build(:permit, house_area: nil, status: "enter_address")).to be_valid }
    it { expect(FactoryGirl.build(:permit, house_area: nil, status: "display_permits")).to be_valid }
    it { expect(FactoryGirl.build(:permit, house_area: "a", status: "enter_address")).to be_valid }
    it { expect(FactoryGirl.build(:permit, house_area: "a", status: "display_permits")).to be_valid }

    it { expect(FactoryGirl.build(:permit, addition_area: nil, status: "enter_address")).to be_valid }
    it { expect(FactoryGirl.build(:permit, addition_area: nil, status: "display_permits")).to be_valid }
    it { expect(FactoryGirl.build(:permit, addition_area: "a", status: "enter_address")).to be_valid }
    it { expect(FactoryGirl.build(:permit, addition_area: "a", status: "display_permits")).to be_valid }
    it { expect(FactoryGirl.build(:permit, addition_area: 1000, status: "enter_address")).to be_valid }
    it { expect(FactoryGirl.build(:permit, addition_area: 1000, status: "display_permits")).to be_valid }

    it { expect(FactoryGirl.build(:permit, ac: nil, status: "enter_address")).to be_valid }
    it { expect(FactoryGirl.build(:permit, ac: nil, status: "display_permits")).to be_valid }

    it { expect(FactoryGirl.build(:permit, contractor: nil, status: "enter_address")).to be_valid }
    it { expect(FactoryGirl.build(:permit, contractor: nil, status: "display_permits")).to be_valid }

    it { expect(FactoryGirl.build(:permit, work_summary: nil, status: "enter_address")).to be_valid }
    it { expect(FactoryGirl.build(:permit, work_summary: nil, status: "display_permits")).to be_valid }

    it { expect(FactoryGirl.build(:permit, job_cost: nil, status: "enter_address")).to be_valid }
    it { expect(FactoryGirl.build(:permit, job_cost: nil, status: "display_permits")).to be_valid }

  end

  context "with invalid attributes" do

    it { expect(FactoryGirl.build(:permit, owner_name: nil)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, owner_name: nil, status: "enter_details")).to be_invalid }

    it { expect(FactoryGirl.build(:permit, owner_address: nil)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, owner_address: nil, status: "enter_address")).to be_invalid }
    it { expect(FactoryGirl.build(:permit, owner_address: "155 9th St, San Francisco, CA 94103")).to be_invalid }
    it { expect(FactoryGirl.build(:permit, owner_address: "155 9th St, San Francisco, CA 94103", status: "enter_address")).to be_invalid }

    it { expect(FactoryGirl.build(:permit, addition: false)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, addition: nil)).to be_invalid }

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

    it { expect(FactoryGirl.build(:permit, contractor: nil)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, contractor: nil, status: "enter_details")).to be_invalid }

    it { expect(FactoryGirl.build(:permit, work_summary: nil)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, work_summary: nil, status: "enter_details")).to be_invalid }

    it { expect(FactoryGirl.build(:permit, job_cost: nil)).to be_invalid }
    it { expect(FactoryGirl.build(:permit, job_cost: nil, status: "enter_details")).to be_invalid }
  end

  after(:all) do
    @cosa.destroy
  end
end
