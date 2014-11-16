require 'spec_helper'

describe GeneralRepairPermitPresenter do
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end
  describe '#to_hash' do
    let(:permit) { FactoryGirl.create(:general_repair_permit) }
    let(:presenter) { GeneralRepairPermitPresenter.new(permit.project)}
    it 'fills out the template correctly' do

      form_data = { 
                        'DATE'                => Date.today.strftime("%m/%d/%Y"),
                        'JOB_COST'            => "$2,000.40",
                        'OWNER_NAME'          => "John Doe", 
                        'ADDRESS'             => "302 Madison St, San Antonio, TX 78204",

                        'ADDITIONS_CHECKBOX'  => "X",
                        'SQ_FOOT_HOUSE'       => 1500,
                        'SQ_FOOT_ADDITION'    => 500,
                        'AC_NONE'             => ' ',
                        'AC_WALL_UNIT'        => "X",
                        'AC_EXTENDED'         => ' ',
                        'AC_NEW_SPLIT'        => ' ',

                        'ACCESSORY_STRUCTURE_CHECKBOX' => "X",

                        'DECK_CHECKBOX'           => "X",

                        'POOL_CHECKBOX'           => "X",
                        
                        'CARPORT_COVER_CHECKBOX'  => "X",

                        'GENERAL_REPAIRS_CHECKBOX'  => "X",
                        'WINDOWS_CHECKBOX'          => "X",
                        'NUMBER_WINDOWS'            => 2,
                        'DOORS_CHECKBOX'            => "X",
                        'NUMBER_DOORS'              => 3,
                        'WALLS_CHECKBOX'            => "X",
                        'SIDING_CHECKBOX'           => "X",
                        'FLOOR_STRUCTURAL_CHECKBOX' => "X",

                        # According to DSD logic, homeowner is contractor if they're doing project
                        'CONTRACTOR_NAME'           => "John Doe",
                        'TELEPHONE'                 => "210-245-3453",
                        'EMAIL'                     => "company@company.com",
                        'WORK_SUMMARY'              => "Adding a 500 square-foot room in the backyard",

                        'SIGNATURE'                 => "John Doe  - SIGNED WITH HOMEBASE #{Date.today.strftime('%m/%d/%Y')}"

                      }
      expect(presenter.to_hash).to eq(form_data)
    end
  end

  after(:all) do
    @cosa.destroy
  end
end