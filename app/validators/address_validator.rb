class AddressValidator < ActiveModel::Validator
  def validate(record)

  	if record.lat != nil && record.lng != nil
	    unless CosaBoundary.inCosa?(record.lat, record.lng)
	      record.errors[:owner_address] << ("Sorry, the address you entered is not in San Antonio.  Please enter a San Antonio address.")
	    end
    else
      record.errors[:owner_address] << ("Sorry, we can't validate your address.  Please try again later.")
	  end
  end
end