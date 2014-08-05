require 'geokit'

class AddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

  	if value == nil
  		record.errors[attribute] << ("Sorry, we can't validate your address.  Please try again later.")
  	else
	    address = Geokit::Geocoders::MultiGeocoder.geocode(value)
	    unless CosaBoundary.inCosa?(address.lat, address.lng)
	      record.errors[attribute] << ("Sorry, the address you entered is not in San Antonio.  Please enter a San Antonio address.")
	    end
	  end
  end
end