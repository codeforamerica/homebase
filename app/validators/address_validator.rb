require 'geokit'

class AddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    address = Geokit::Geocoders::MultiGeocoder.geocode(value)
    unless CosaBoundary.inCosa?(address.lat, address.lng)
      record.errors[attribute] << (options[:message] || "is not in San Antonio")
    end
  end
end