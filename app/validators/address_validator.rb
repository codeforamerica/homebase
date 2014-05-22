require 'geokit'

class AddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    address = Geokit::Geocoders::MultiGeocoder.geocode(value)
    unless CosaBoundary.inCosa?(address.lat, address.lng)
      record.errors[attribute] << ("Sorry, the address you entered is not in San Antonio.  Please enter a San Antonio address.")
    end
  end
end