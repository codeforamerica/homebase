require 'rgeo/shapefile'

namespace :cosa_boundaries do
  desc "Load COSA Boundary into database"
  task :load => :environment do

    CosaBoundary.destroy_all
    shpfile = "#{Rails.root}/lib/assets/SCosaBoundary/pdsCosaBoundary_1.shp"
    
    RGeo::Shapefile::Reader.open(shpfile, {:srid => 2278}) do |file|
      puts "File contains #{file.num_records} records"
      file.each do |n|
         record = n.attributes
         puts n.attributes
         CosaBoundary.create( :name => record["Name"], 
                              :acres => record["Acres"],
                              :sqmiles => record["SqMiles"],
                              :shape_area => record["Shape_area"],
                              :shape_leng => record["Shape_len"], 
                              :geom => n.geometry)
      end
    end
  end

  desc "Empty COSA Boundary table"  
  task :drop => :environment  do |t, args|
    CosaBoundary.destroy_all
  end

end
