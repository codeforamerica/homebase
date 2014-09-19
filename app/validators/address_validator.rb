class AddressValidator < ActiveModel::Validator
  def validate(record)

    # @TODO: Check if this is valid
  	if record.lat != nil && record.lng != nil
      inCosa = CosaBoundary.inCosa?(record.lat, record.lng)
      
	    unless inCosa
	      record.errors[:owner_address] << (I18n.t('validators.address_validator.error.not_in_cosa'))
	    end
    else
      record.errors[:owner_address] << (I18n.t('validators.address_validator.error.internal'))
	  end
  end
end