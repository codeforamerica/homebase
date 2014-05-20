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
         CosaBoundary.create( :name => record["name"], 
                              :sqmiles => record["sqmiles"],
                              :shape_area => record["shape_area"],
                              :shape_leng => record["shape_len"], 
                              :geom => n.geometry)
      end
    end
  end

  desc "Empty COSA Boundary table"  
  task :drop => :environment  do |t, args|
    CosaBoundary.destroy_all
  end

end
