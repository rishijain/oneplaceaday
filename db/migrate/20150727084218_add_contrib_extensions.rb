class AddContribExtensions < ActiveRecord::Migration
  def change
  	execute 'CREATE EXTENSION pg_trgm;'
  	execute 'CREATE EXTENSION fuzzystrmatch;'
  end
end
