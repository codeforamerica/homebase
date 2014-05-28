require 'spec_helper'

describe Permit do
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  context "with valid attributes" do
  	it { expect(FactoryGirl.create(:permit)).to be_valid }
  end

  context "with invalid attributes" do
  	it { expect(FactoryGirl.build(:permit, owner_name: nil)).to be_invalid }
  	it { expect(FactoryGirl.build(:permit, owner_address: nil)).to be_invalid }
  	it { expect(FactoryGirl.build(:permit, addition: false)).to be_invalid }
  	it { expect(FactoryGirl.build(:permit, addition: nil)).to be_invalid }
  end

  after(:all) do
    @cosa.destroy
  end
end
# describe Post do
#   context "with 2 or more comments" do
#     it "orders them in reverse" do
#       post = Post.create
#       comment1 = post.comment("first")
#       comment2 = post.comment("second")
#       post.reload.comments.should eq([comment2, comment1])
#     end
#   end
# end

    # owner_name        "John Doe"
    # owner_address     "302 Madison St, San Antonio, TX 78204"
    # addition          true
    # house_area        1500
    # addition_area     500
    # ac                "Wall Unit"
    # contractor        true
    # contractor_name   "Rick Smith"
    # contractor_id     "A12345"
    # escrow            true
    # license_holder    "Jane Dolly"
    # license_num       "B34567"
    # agent_name        "Will Tom"
    # contact_id        "V03458"
    # other_contact_id  "U09356"
    # phone             "210-245-3453"
    # fax               "210-948-3432"
    # email             "company@company.com"
    # work_summary      "Adding a 500 square-foot room in the backyard"
    # job_cost          "2000"
    # status            "active"