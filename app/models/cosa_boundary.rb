class CosaBoundary < ActiveRecord::Base

  # self.primary_key = 'gid'
  # self.table_name = 'historicdistricts'

  COORD_SYS_REF = 4326;   # The coordinate system that will be used as the reference and is now Latitude and Longitude Coord System
  COORD_SYS_AREA = 2278;  # The coordinate system used in the data Texas South Central Coordinate System

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
end
