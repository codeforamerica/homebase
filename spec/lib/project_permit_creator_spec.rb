require 'spec_helper'

describe ProjectPermitCreator do
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  describe '#create_permit' do
    let(:permit) { FactoryGirl.create(:general_repair_permit) }
    let(:file_path) { Rails.root.join('tmp', 'rspec') }
    let(:pdftk) { PdfForms.new('pdftk') }
    let(:project_permit_creator) { ProjectPermitCreator.new(file_path, permit.project, pdftk) }

    it 'creates the pdf at the file path' do
      project_permit_creator.create_permit
      expect(File.exists?(file_path)).to eq(true)
    end

    it 'fills in the correct template' do
      template_path = "#{Rails.root}/lib/PermitForms/general-repairs-form-template.pdf"
      expect(pdftk).to receive(:fill_form).with(template_path, anything, anything, anything)
      project_permit_creator.create_permit
    end

    it 'writes to the correct file path' do
      expect(pdftk).to receive(:fill_form).with(anything, file_path, anything, anything)
      project_permit_creator.create_permit      
    end

    it "flattens the file" do
      expect(pdftk).to receive(:fill_form).with(anything, anything, anything, flatten: true)
      project_permit_creator.create_permit   
    end
  end
  
  after(:all) do
    @cosa.destroy
  end
end
