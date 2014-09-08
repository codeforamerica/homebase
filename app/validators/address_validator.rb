class AddressValidator < ActiveModel::Validator
  def validate(record)

    # @TODO: Check if this is valid
  	if record.lat != nil && record.lng != nil
      inCosa = CosaBoundary.inCosa?(record.lat, record.lng)
      
	    unless inCosa
	      record.errors[:owner_address] << ("Sorry, we think we got your address wrong here. Would you mind double checking it's in San Antonio?")
	    end
    else
      record.errors[:owner_address] << ("Sorry, we can't validate your address right now.  Would you mind trying again later?")
	  end
  end
end