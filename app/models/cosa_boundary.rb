class CosaBoundary < ActiveRecord::Base

  COORD_SYS_REF = 4326;   # The coordinate system that will be used as the reference and is now Latitude and Longitude Coord System
  COORD_SYS_AREA = 2278;  # The coordinate system used in the data Texas South Central Coordinate System
  SA_BOUNDS = Geokit::Geocoders::MultiGeocoder.geocode('San Antonio, TX').suggested_bounds

  def self.inCosa? lat, long
    inCosa = false
    if lat != nil && long != nil
    # figure out if it is in a specific area in 
      @spec_area = CosaBoundary.where("ST_Contains(geom, ST_Transform(ST_SetSRID(ST_MakePoint(?, ?), ?), ?))",
                                                long,
                                                lat,
                                                COORD_SYS_REF,
                                                COORD_SYS_AREA)

      inCosa = @spec_area.exists?
    end
    
    return inCosa
  end

  def self.address_details address
    begin
      if address
        address_details = Geokit::Geocoders::MultiGeocoder.geocode(address, bias: SA_BOUNDS)
      end
    # @TODO: Is this necessary still?
    rescue Geokit::Geocoders::TooManyQueriesError
      puts "Error with Geocoders!!!"
      return nil
    end

    if valid_address?(address_details)
      return { :full_address => address_details.full_address, :lat => address_details.lat, :lng => address_details.lng }
    else
      return nil
    end
  end

  private
  
  def self.valid_address? address
    address != nil && address.lat != nil && address.lng != nil && address.full_address != nil && address.street_name != nil
  end
end
