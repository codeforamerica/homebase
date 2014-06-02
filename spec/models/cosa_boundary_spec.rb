require 'spec_helper'

describe CosaBoundary do

  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  describe ".inCosa?" do
    context 'when lat long is in' do
      # Lat Long of 302 Madison St, San Antonio
      let (:answer) { CosaBoundary.inCosa? 29.414432, -98.491916 }

      it { expect(answer).to be_true }
    end

    context 'when lat long is not in' do
      # Lat Long of 155 9th St, San Francisco
      let (:answer) { CosaBoundary.inCosa? 37.775518,-122.413821 }

      it { expect(answer).to be_false }
    end
  end

  

  after(:all) do
    @cosa.destroy
  end

end
