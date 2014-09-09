require 'spec_helper'

describe PermitBinaryDetail do
  describe "#before_create" do
    detail = FactoryGirl.create(:permit_binary_detail)
    binary = Binary.find_by(id: detail.binary_id)
    it "returns a valid detail and binary" do
      expect(detail.content_type).to eq("application/pdf")
      expect(detail.filename).to eq("test.pdf")
      expect(binary).not_to be_nil
      # Need custom matcher to compare binary
      #expect(binary.data).to be_same_file_as(IO.binread "#{Rails.root}/spec/test.pdf")

   end
  end
end
