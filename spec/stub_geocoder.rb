require "geokit"

  module Geokit
    module Geocoders

      # and use :my to specify this geocoder in your list of geocoders.
      class StubGeocoder < Geocoder

        # Use via: Geokit::Geocoders::StubGeocoder.key = 'STUB KEY'
        config :key

        private

        def self.do_geocode(address, options = {})
          # Main geocoding method
          h = { :street_address => "302 Madison Street",
                :street_number => "302",
                :street_name => "Madison Street",
                :city => "San Antonio",
                :state => "TX",
                :zip => "78204", 
                :country_code => "US", 
                :province => "TX", 
                :success => true, 
                :precision => "building", 
                :full_address => "302 Madison Street, San Antonio, TX 78204, USA",
                :lat => 29.4143752, 
                :lng => -98.4917627, 
                :provider => "stub", 
                :district => "Bexar County", 
                :country => "United States", 
                :accuracy => 9,
                :neighborhood => "Arsenal" }

          geo = GeoLoc.new(h)
          geo.provider = "stub"
          geo.success = true
          geo.precision = 9


          return geo
        end

        def self.parse_json(json)
          # Helper method to parse http response. See geokit/geocoders.rb.
          puts "stubgeocoder: got in parse_json"
        end
      end

    end
  end