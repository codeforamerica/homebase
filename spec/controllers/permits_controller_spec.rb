require 'spec_helper'

describe PermitsController do
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  describe "GET #new" do

    context "when in district address is passed in" do
#      before { get :new, :format => 'html', :permit => FactoryGirl.build(:permit, )}

      # it { expect(json['lat']).to be_within(0.01).of(29.414432) }
      # it { expect(json['lng']).to be_within(0.01).of(-98.491916) }
      # it { expect(json['in_hist_district']).to be_true }
      # it { expect(json['hist_district_polygon']).not_to be_nil }
      # it { expect(json['in_cosa_district']).to be_true }
      # it { expect(json['cosa_district_polygon']).not_to be_nil }

      # it { should respond_with 200 }
    end
  end

end
