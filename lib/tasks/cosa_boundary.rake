require 'rgeo/shapefile'

namespace :cosa_boundary do
  desc "Load COSA Boundary into database"
  task :load => :environment do

    CosaCouncilDistrict.destroy_all
    shpfile = "#{Rails.root}/lib/assets/SCosaBoundary/pdsCosaBoundary.shp"
    
    RGeo::Shapefile::Reader.open(shpfile, {:srid => -1}) do |file|
      puts "File contains #{file.num_records} records"
      file.each do |n|
         record = n.attributes
         CosaCouncilDistrict.create(:district => record["District"],
                                    :name => record["Name"], 
                                    :sqmiles => record["SqMiles"],
                                    :shape_area => record["Shape_area"],
                                    :shape_leng => record["Shape_len"], 
                                    :geom => n.geometry)
      end
    end
  end

  desc "Empty COSA council district table"  
  task :drop => :environment  do |t, args|
    CosaCouncilDistrict.destroy_all
  end

end
