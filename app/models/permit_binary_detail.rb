class PermitBinaryDetail < ActiveRecord::Base
  belongs_to :binary,  :dependent => :destroy
  belongs_to :permit
  attr_accessor :file_data
  before_create :create_binary

  private
    def create_binary
      input = self.file_data
      @binary = Binary.create(data: input)
      self.binary_id = @binary.id
      self.content_type = 'application/pdf'
      self.size = @binary.data.size
    end
end
