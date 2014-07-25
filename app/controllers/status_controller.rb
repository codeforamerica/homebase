# Dependencies explanation
# GEOS - Uses to add Geospatial data in database and run tests
# Postgres - Database for address validation and Permit
# PDFTK - Use to generate permit PDF

require 'rgeo'
require 'pdf-forms'

class StatusController < ApplicationController

  def check
    response_hash = Hash.new
    #{ :status => "ok", :updated => "", :dependencies => "", :resources => "" }
    response_hash[:dependencies] = [ "postgres", "geos", "pdftk" ]
    response_hash[:status] = everything_ok? ? "ok" : "NOT OK"
    response_hash[:updated] = Time.now.to_i
    response_hash[:resources] = {}
    render :inline => response_hash.to_json
  end

  private
  def everything_ok?
    # Check that we have some database presence and core data is available
    database_okay? && geos_okay? && pdftk_okay?
  end

  def database_okay?
    CosaBoundary.first.present?
  end

  def geos_okay?
    RGeo::Geos.supported?
  end

  def pdftk_okay?
    begin
      PdfForms.new('pdftk')
      true
    rescue
      false
    end
  end

end