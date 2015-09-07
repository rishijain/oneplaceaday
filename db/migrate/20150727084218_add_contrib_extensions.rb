class AddContribExtensions < ActiveRecord::Migration
  def change
    execute 'CREATE EXTENSION IF NOT EXISTS pg_trgm;'
    execute 'CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;'
  end
end
